FROM debian:bullseye-slim AS builder
LABEL maintainer="ivan@tunguska.cc"
LABEL org.opencontainers.image.source="https://github.com/tunguskacc/airdump"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBIAN_VERSION="bullseye"

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends ca-certificates curl build-essential fakeroot debhelper librtlsdr-dev pkg-config libncurses5-dev libbladerf-dev libhackrf-dev liblimesuite-dev dpkg-dev\
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://github.com/flightaware/dump1090/archive/refs/tags/v7.1.tar.gz | tar -v -C /usr/local/src/ -xz

WORKDIR /usr/local/src/dump1090-7.1
RUN make clean && ./prepare-build.sh ${DEBIAN_VERSION} && dpkg-buildpackage -b --no-sign


FROM builder AS deploy

ARG ARCH

COPY --from=builder /usr/local/src/dump1090-fa_7.1_${ARCH}.deb ./dump1090-fa_7.1_${ARCH}.deb
COPY ./init /init

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends librtlsdr0 lighttpd libncurses6 libhackrf0 libbladerf2  liblimesuite20.10-1 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && dpkg -i ./dump1090-fa_7.1_${ARCH}.deb


ENTRYPOINT "/init"
