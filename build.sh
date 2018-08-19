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

adduser -G abuild -D build
chmod a+w /var/cache/distfiles
echo 'build ALL=(ALL) NOPASSWD: ALL' | EDITOR='tee -a' visudo

# Switch to the build user.

sudo -H -u build /bin/sh <<EOF
cd /home/build
cp /build-src/APKBUILD .

# Prepare private key for signing.

openssl aes-256-cbc -K $encrypted_16f110ae354d_key -iv $encrypted_16f110ae354d_iv \
    -in /build-src/oftr-5b74d058.rsa.enc -out oftr-5b74d058.rsa -d

mkdir .abuild
echo "PACKAGER_PRIVKEY=/home/build/oftr-5b74d058.rsa" > .abuild/abuild.conf

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
