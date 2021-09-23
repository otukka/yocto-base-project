
FROM ubuntu:18.04 as base

RUN apt-get update && apt-get install -y \
gawk \
wget \
git-core \
diffstat \
unzip \
texinfo \
gcc-multilib \
build-essential \
chrpath \
socat \
curl \
cmake \
cpio \
pax \
flex \
bison \
libselinux1 \
gnupg \
libssl-dev \
gzip \
screen \
libtool \
autoconf \
xterm \
tar \
zlib1g-dev \
python \
xterm \
libsdl1.2-dev


RUN mkdir /xsct \
&& cd /xsct \
&& curl http://petalinux.xilinx.com/sswreleases/rel-v2019/xsct-trim/xsct-2019-2.tar.xz --output xsct-2019-2.tar.xz\
&& tar -xJf xsct-2019-2.tar.xz \
&& rm xsct-2019-2.tar.xz


FROM base AS extended

RUN apt-get update && apt-get install -y \
libidn11 \
iproute2

RUN apt-get update && apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



RUN useradd -m yocto && echo "yocto:yocto" | chpasswd && adduser yocto sudo \
&& mkdir /work \
&& chown -R yocto:yocto /work \
&& chown yocto:yocto /xsct/Vitis/2019.2

# newest cmake
RUN apt remove --purge --auto-remove cmake -y \
&& apt update && apt install gpg -y\
&& wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null \
&& echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null \
&& apt update \
&& rm /usr/share/keyrings/kitware-archive-keyring.gpg \
&& apt install kitware-archive-keyring -y \
&& apt install cmake -y



USER yocto

RUN mkdir /work/downloads && mkdir /work/sstate-cache


WORKDIR /work
