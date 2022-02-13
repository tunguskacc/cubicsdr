#!/bin/bash

docker build . --platform amd64 --target builder --build-arg ARCH=amd64 -t tunguskacc/dump1090-fa:amd64 -t tunguskacc/dump1090-fa:latest -t tunguskacc/dump1090-fa
docker build . --platform arm64 --target builder --build-arg ARCH=arm64 -t tunguskacc/dump1090-fa:arm64

docker run --name cubicsdramd64 -d tunguskacc/dump1090-fa:amd64
docker cp cubicsdramd64:/usr/local/src/dump1090-fa_7.1_amd64.deb .
sleep 1
docker rm cubicsdramd64

docker run --name cubicsdrarm64 -d tunguskacc/dump1090-fa:arm64
docker cp cubicsdrarm64:/usr/local/src/dump1090-fa_7.1_arm64.deb .
sleep 1
docker rm cubicsdrarm64