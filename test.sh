#!/bin/bash

# Build docker image if not present
if ! docker images|grep yoctobuilder -q; then
    docker build -t yoctobuilder .
fi



# Docker usually do not handle folder mounts properly if the folders are not present.
# Do not remove these between builds.
if [[ ! -e "downloads" ]]; then
    mkdir downloads
    chmod 777 downloads
fi
if [[ ! -e "sstate-cache" ]]; then
    mkdir sstate-cache
    chmod 777 sstate-cache
fi
if [[ ! -e "output" ]]; then
    mkdir output
    chmod 777 output
fi
if [[ ! -e "build" ]]; then
    mkdir build
    chmod 777 build
fi


# Run yocto build using docker container
docker run -it --rm \
-u yocto:yocto \
-v ${PWD}:/work/ \
-t yoctobuilder \
/bin/bash -c /work/build.sh || exit 1

# /bin/bash -c /work/qemu.sh || exit 1
# -v ${PWD}/qemu.sh:/work/qemu.sh \
# -v ${PWD}/../Xilinx/xilinx-zcu102-v2019.2-final/xilinx-zcu102-2019.2/pre-built/linux/images/pmu_rom_qemu_sha3.elf:/work/pmu_rom_qemu_sha3.elf \


# Install sdk
# sh output/poky-glibc-x86_64-core-image-minimal-aarch64-toolchain-2.6.1.sh -y 