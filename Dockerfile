FROM debian:bullseye-slim
LABEL maintainer="ivan@tunguska.cc"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt update  \
    && apt upgrade -y \
    && apt install -y --no-install-recommends dante-server wireguard-tools iproute2 procps iptables \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# FROM scratch
COPY ./danted.conf /etc/
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"

