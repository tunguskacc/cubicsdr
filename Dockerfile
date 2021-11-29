FROM debian:bullseye-slim
LABEL maintainer="ivan@tunguska.cc"
LABEL org.opencontainers.image.source="https://github.com/tunguskacc/wireguard-socks-proxy"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt update && apt upgrade -y \
    && apt install -y --no-install-recommends dante-server wireguard-tools iproute2 procps iptables \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./danted.conf /etc/
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"
