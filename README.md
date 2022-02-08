# AirDUMP
 
Based on dump1090 for ADB-C RTS SDR.

## ARM64 build

Building ARM packages:

```
sudo apt-get install qemu binfmt-support qemu-user-static # Install the qemu packages
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes # This step will execute the registering scripts
```