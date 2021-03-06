ARG ARCH=amd64
ARG DEBIANVERSION=bullseye
FROM --platform=linux/${ARCH} debian:${DEBIANVERSION}-slim as build-wx
ARG DEBIANVERSION
ARG DEBIAN_FRONTEND="noninteractive"

LABEL org.opencontainers.image.authors="Ivan M <ivan@tunguska.cc>"
LABEL org.opencontainers.image.source="https://github.com/tunguskacc/cubicsdr"
LABEL org.opencontainers.image.vendor="Tunguska CC"
LABEL org.opencontainers.image.title="cubicsdr"

ENV DISPLAY :0

RUN apt update && apt upgrade -y  \
    && apt install -y --no-install-recommends ca-certificates curl build-essential automake cmake libpulse-dev freeglut3  \
    freeglut3-dev libsoapysdr-dev libgtk-3-dev xterm xserver-xorg-core x11-utils xinit xserver-xorg-input-evdev \
    pulseaudio librtlsdr0 libhackrf0 libsoapysdr0.8 soapysdr-module-all gr-osmosdr avahi-daemon libhamlib-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 1000 imarin \
    && useradd -ms /bin/bash imarin -u 1000 -g 1000

# wxWidgets
RUN curl -sSL https://github.com/wxWidgets/wxWidgets/releases/download/v3.1.5/wxWidgets-3.1.5.tar.bz2 | tar xvfj - -C /usr/local/src/
WORKDIR /usr/local/src/wxWidgets-3.1.5/
RUN mkdir static && ./autogen.sh && ./configure --prefix=`echo /usr/local/src/wxWidgets-3.1.5/static` --with-opengl \
    --disable-glcanvasegl --disable-shared --enable-monolithic --with-libjpeg --with-libtiff --with-libpng --with-zlib \
    --disable-sdltest --enable-unicode --enable-display --enable-propgrid --disable-webview --disable-webviewwebkit CXXFLAGS="-std=c++0x" \
    && make -j4 && make install && make clean

# liquid-DSP
RUN curl -sSL https://github.com/jgaeddert/liquid-dsp/archive/refs/tags/v1.4.0.tar.gz | tar xvfz - -C /usr/local/src/
WORKDIR /usr/local/src/liquid-dsp-1.4.0/
RUN ./bootstrap.sh &&  CFLAGS="-march=native -O3" ./configure --enable-fftoverride && make -j4 && make install && ldconfig && make clean

FROM build-wx
# cubicSDR
RUN curl -sSL https://github.com/cjcliffe/CubicSDR/archive/refs/tags/0.2.7.tar.gz | tar -v -C /usr/local/src/ -xz
WORKDIR /usr/local/src/CubicSDR-0.2.7/
RUN mkdir build && cd build && cmake ../ -DCMAKE_BUILD_TYPE=Release \
    -DwxWidgets_CONFIG_EXECUTABLE=/usr/local/src/wxWidgets-3.1.5/static/bin/wx-config -DUSE_HAMLIB=1 && \
    make -j4 && make install && make clean

COPY ./init ./init
CMD ["./init"]
# ENTRYPOINT "./init"
