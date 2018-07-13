#!/bin/sh
#
# Script to build an alpine package.

set -e
set -u

if [ -z ${OFTR_VERSION+x} ]; then
    echo "OFTR_VERSION environment variable is not set."
    exit 1
fi

# Install the alpine-sdk.

apk update
apk add alpine-sdk

# Determine architecture.

ARCH=$(abuild -A)
echo "Building ${ARCH} alpine package for oftr-${OFTR_VERSION}"

# Create the 'build' user and add it to the 'abuild' group. Make sure
# it has read/write access to /var/cache/distfiles. We also need to
# add 'build' to /etc/sudoers.

adduser -D build
addgroup build abuild
chmod a+w /var/cache/distfiles
echo 'build ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

# Switch to the build user.

sudo -H -u build /bin/sh <<EOF
cd /home/build
cp /build-src/APKBUILD .

# Generate a disposable public/private key pair.

abuild-keygen -a -n

# Update the checksum in the APKBUILD file.

abuild checksum

# Build the package.

abuild -r

EOF

# The resulting packages are stored in "/home/build/packages/home/$ARCH/*.apk"

PKG_DIR="/home/build/packages/home/$ARCH"
OUT_DIR="/build-src/output"

mkdir "$OUT_DIR"
cp $PKG_DIR/*.apk "$OUT_DIR"

exit 0
