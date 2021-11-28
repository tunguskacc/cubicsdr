FROM debian:bullseye-slim
LABEL maintainer="ivan@tunguska.cc"
ARG DEBIAN_FRONTEND="noninteractive"

RUN apt update  \
    && apt upgrade -y \
    && apt install -y dante-server wireguard-tools  \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./sockd.conf /etc/
COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT "/entrypoint.sh"