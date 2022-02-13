#!/bin/bash

docker run --name cubicsdramd64 -d tunguskacc/dump1090-fa:amd64
docker cp cubicsdramd64:/usr/local/src/dump1090-fa_7.1_amd64.deb .