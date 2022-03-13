# CubicSDR
 
Builds [CubicSDR](https://cubicsdr.com/) from [latest release](https://github.com/cjcliffe/CubicSDR/releases) 
in Debian Bookworm and runs it inside Docker.

## docker-compose

Use `docker-compose` to build and run. The command is

```bash
docker-compose up -d
```

## Changing Debian version

You can change the Debian version in the variable `DEBIANVERSION` in the docker-compose file.

## Changing architecture

You can also change the architecture on the variable `ARCH` in the docker-compose file. Tested with `amd64` and `arm64`.