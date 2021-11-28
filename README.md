# wireguard-socks-proxy

Expose WireGuard as a SOCKS5 proxy in a Docker container.

This is a update from the [docker-wireguard-socks-proxy](https://hub.docker.com/r/kizzx2/wireguard-socks-proxy), 
now using Debian and adapting to the network interfaces.

## How to run

You can run it with the following command:

```bash
docker run \
    --rm --tty --interactive \
    --name=wireguard-socks-proxy \
    --cap-add=NET_ADMIN \
    --publish 127.0.0.1:1080:1080 \
    --sysctl net.ipv4.conf.all.src_valid_mark=1 \
    --privileged \
    --volume "/etc/wireguard:/etc/wireguard/:ro" \
    tunguskacc/wireguard-socks-proxy
```

Or use directly the `start.sh` script:
```bash
bash start.sh /directory/containing/your/wireguard/conf/file
```

Then connect to SOCKS proxy through through `127.0.0.1:1080` (or `local.docker:1080` for Mac / docker-machine / etc.). For example:

```bash
curl --proxy socks5h://127.0.0.1:1080 ipinfo.io
```

## FAQ

### Why you need to run with privileged?

Wireguard changed since the original image was published, and now it requires sysctl permissions. 
See [here](https://hub.docker.com/r/jordanpotter/wireguard) for more context.
