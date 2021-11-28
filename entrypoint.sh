#!/bin/sh

set -e

wg-quick up /etc/wireguard/wg0.conf
/usr/sbin/sockd
