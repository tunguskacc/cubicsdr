#!/bin/bash

docker build . --platform amd64 --target builder --build-arg ARCH=amd64 -t tunguskacc/dump1090-fa:amd64 -t tunguskacc/dump1090-fa:latest -t tunguskacc/dump1090-fa
docker build . --platform arm64 --target builder --build-arg ARCH=arm64 -t tunguskacc/dump1090-fa:arm64

docker run --name airdumpamd64 -d tunguskacc/dump1090-fa:amd64
docker cp airdumpamd64:/usr/local/src/dump1090-fa_7.1_amd64.deb .
sleep 1
docker rm airdumpamd64

docker run --name airdumparm64 -d tunguskacc/dump1090-fa:arm64
docker cp airdumparm64:/usr/local/src/dump1090-fa_7.1_arm64.deb .
sleep 1
docker rm airdumparm64