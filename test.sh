#!/bin/bash

# Build docker file
if ! docker images|grep yoctobuilder -q; then
    docker build --build-arg USER_ID=$(id -u) --build-arg GROUP_ID=$(id -g) -t yoctobuilder .
fi

# Remove old results
if [[ -d "build" ]]; then
    rm -rf build
fi

if [[ -d "output" ]]; then
    rm -rf output
fi

mkdir build
mkdir output

# Docker usually do not handle folder mounts properly if the folders are not present
if [[ ! -d "downloads" ]]; then
    mkdir downloads
fi

if [[ ! -d "sstate-cache" ]]; then
    mkdir sstate-cache
fi



# Run yocto build using docker container
docker run -it --rm \
-v ${PWD}/sstate-cache/:/work/sstate-cache \
-v ${PWD}/downloads/:/work/downloads \
-v ${PWD}/meta-browser/:/work/meta-browser \
-v ${PWD}/meta-openamp/:/work/meta-openamp \
-v ${PWD}/meta-petalinux/:/work/meta-petalinux \
-v ${PWD}/meta-virtualization/:/work/meta-virtualization \
-v ${PWD}/meta-xilinx-petalinux/:/work/meta-xilinx-petalinux \
-v ${PWD}/poky/:/work/poky \
-v ${PWD}/meta-jupyter/:/work/meta-jupyter \
-v ${PWD}/meta-openembedded/:/work/meta-openembedded \
-v ${PWD}/meta-qt5/:/work/meta-qt5 \
-v ${PWD}/meta-xilinx/:/work/meta-xilinx \
-v ${PWD}/meta-xilinx-tools/:/work/meta-xilinx-tools \
-v ${PWD}/meta-own/:/work/meta-own \
-v ${PWD}/build/:/work/build \
-v ${PWD}/output/:/work/output \
-v ${PWD}/build.sh:/work/build.sh \
-t yoctobuilder \
/bin/bash -c /work/build.sh || exit 1


# Install sdk
sh output/poky-glibc-x86_64-core-image-minimal-aarch64-toolchain-2.6.1.sh -y 