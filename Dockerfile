FROM debian:bullseye-slim AS builder
LABEL maintainer="ivan@tunguska.cc"
LABEL org.opencontainers.image.source="https://github.com/tunguskacc/dump1090-flightaware"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBIAN_VERSION="bullseye"

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends git build-essential fakeroot debhelper librtlsdr-dev pkg-config libncurses5-dev libbladerf-dev libhackrf-dev liblimesuite-dev dpkg-dev\
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./dump1090 /dump1090
WORKDIR /dump1090
RUN make clean && ./prepare-build.sh bullseye && dpkg-buildpackage -b --no-sign

FROM builder AS build-1
COPY --from=builder ./dump1090-fa_7.1_amd64.deb ./dump1090-fa_7.1_amd64.deb

FROM builder AS deploy

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends librtlsdr0 lighttpd libncurses6 libhackrf0 libbladerf2  liblimesuite20.10-1 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
RUN dpkg -i ./dump1090-fa_7.1_amd64.deb


COPY ./init /init
ENTRYPOINT "/init"
