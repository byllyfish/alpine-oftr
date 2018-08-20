Build Alpine Package for OFTR
=============================

This repository builds the Alpine Linux packages for oftr.

x86_64
------

To build the Alpine packages for x86_64, push a tag to Github and let Travis-ci do the rest::

    git tag 0.x.y
    git push origin 0.x.y

Travis-ci will deploy the built packages to Github Releases.

Raspberry Pi
------------

To build the Alpine packages for the Raspberry Pi (armhf), you must build them on an actual Raspberry Pi::

    sudo docker build -t alpine-oftr -f Dockerfile .
    sudo docker run --name build-oftr --env-file env.list alpine-oftr
    docker cp build-oftr:/build-src/output .

The env.list file should look like this::

    # Replace version and fill in ... with actual keys.
    OFTR_VERSION=0.x.y
    encrypted_16f110ae354d_key=...
    encrypted_16f110ae354d_iv=...

Upload the .apk files to a Github release named "<version>-pi".
