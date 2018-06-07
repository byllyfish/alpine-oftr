## Image name: byllyfish/alpine-oftr

FROM alpine:3.7

COPY ./ /build-src/

RUN /build-src/build.sh
