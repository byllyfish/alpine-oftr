#!/bin/sh
#
# Script to build an alpine package.

set -e
set -u

# Install the alpine-sdk.

apk update
apk add alpine-sdk

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

# Generate a disposable public/private key pair. The private
# key will be used to sign the APKINDEX, but we throw away that
# artifact.

abuild-keygen -a -n

# Optionally update the checksum in the APKBUILD file?
#abuild checksum

# Build the package.

abuild -r

EOF

# The resulting packages are stored in "/home/build/packages/home/$ARCH/*.apk"
# We ignore the index file named "APKINDEX.tar.gz".
