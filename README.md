# CubicSDR
 
Builds CubicSDR from latest release in Debian and runs it inside Docker.

## ARM64 build

Building ARM packages:

```
sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts
```

and build with

```
docker build --platform arm64 -t tunguskacc/cubicsdr-arm64 --build-arg ARCH=arm64 .
docker build --platform amd64 -t tunguskacc/cubicsdr-amd64 --build-arg ARCH=amd64 .
docker push registry.tunguska.cc/cubicsdr:multiarch-amd64
docker push registry.tunguska.cc/cubicsdr:multiarch-arm64
docker manifest create registry.tunguska.cc/cubicsdr:latest registry.tunguska.cc/cubicsdr:multiarch-amd64 registry.tunguska.cc/cubicsdr:multiarch-arm64
docker manifest push registry.tunguska.cc/cubicsdr:latest
```


