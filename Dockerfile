FROM debian:stable-slim as download
ARG TAG=1.3.0
WORKDIR /mibs
RUN set -xe \
 && apt-get update \
 && apt-get install -y curl ca-certificates \
 && curl -fsSL https://github.com/cisco-kusanagi/mibs.snmplabs.com/archive/$TAG.tar.gz \
    | tar -zx \
 && mv mibs.snmplabs.com-$TAG mibs.snmplabs.com

FROM busybox:1.31
COPY --from=download /mibs  /mibs
