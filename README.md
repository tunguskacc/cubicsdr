# AirDUMP
 
Based on dump1090 for ADB-C RTS SDR.

## ARM64 build

Building ARM packages:

```
sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts
```

and build with

```
docker build --platform arm64 -t tunguskacc/airdump-arm64 --build-arg ARCH=arm64 .
docker build --platform amd64 -t tunguskacc/airdump-amd64 --build-arg ARCH=amd64 .
docker push registry.tunguska.cc/airdump:multiarch-amd64
docker push registry.tunguska.cc/airdump:multiarch-arm64
docker manifest create registry.tunguska.cc/airdump:latest registry.tunguska.cc/airdump:multiarch-amd64 registry.tunguska.cc/airdump:multiarch-arm64
docker manifest push registry.tunguska.cc/airdump:latest
```


