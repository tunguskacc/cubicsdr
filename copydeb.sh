#!/bin/bash

docker run --name airdumpamd64 -d tunguskacc/dump1090-fa:amd64
docker cp airdumpamd64:/usr/local/src/dump1090-fa_7.1_amd64.deb .