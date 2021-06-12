# Build docker image:
# $ docker build -t yoctobuilder --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) .
# Run container:
# $ docker run -it --rm -v ${PWD}/downloads:/work/downloads -v ${PWD}/sstate-cache:/work/sstate-cache -t yoctobuilder build.sh
FROM ubuntu:18.04

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
libsdl1.2-dev \
libidn11

RUN apt-get update && apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8



ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID yocto
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID yocto

RUN mkdir /work
RUN mkdir /xsct

RUN chown -R yocto /work
RUN chown -R yocto /xsct
USER yocto

RUN mkdir /work/downloads
RUN mkdir /work/sstate-cache

ENV USE_XSCT_TARBALL="0"
ENV XILINX_SDK_TOOLCHAIN="/xsct/Vitis/2019.2"
RUN cd /xsct \
&& wget http://petalinux.xilinx.com/sswreleases/rel-v2019/xsct-trim/xsct-2019-2.tar.xz \
&& tar -xJf xsct-2019-2.tar.xz

WORKDIR /work
