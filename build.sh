#!/bin/sh
#
# Script to build an alpine package.

set -e
set -u

# Install the alpine-sdk.

apk update
apk add alpine-sdk

# Create the 'build' user and add it to the 'abuild' group. Make sure
# it has read/write access to /var/cache/distfiles.

adduser -D build
addgroup build abuild
chmod a+w /var/cache/distfiles
#sed -i 's/#PACKAGER=.*/PACKAGER="Bill Fisher <william.w.fisher@gmail.com>"/' /etc/abuild.conf &&\

# Switch to the build user, and generate a disposable public/private key pair. The private
# key will be used to sign the APKINDEX, but we throw away that artifact.

su -l -s /bin/sh build
export PATH=/usr/sbin:/sbin:$PATH
abuild-keygen -a -n

# Optionally update the checksum in the APKBUILD file?
#abuild checksum

# Build the package.

abuild -r

# The resulting packages are stored in "/home/build/packages/build/$ARCH/*.apk"
# We ignore the index file named "APKINDEX.tar.gz".
