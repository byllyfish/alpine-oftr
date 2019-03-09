## Image name: byllyfish/alpine-oftr

FROM alpine:3.9

COPY ./ /build-src/

CMD /build-src/build.sh
