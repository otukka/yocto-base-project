#!/bin/bash

ROOT="${PWD}"
DOWNLOADS="${ROOT}/downloads/"
SSTATE="${ROOT}/sstate-cache"

rm -rf "${ROOT}/build/conf/"


export TEMPLATECONF="${ROOT}/meta-own/conf"

# export MACHINE="custom1-zcu111-zynqmp"
# export MACHINE="custom2-zcu111-zynqmp"
# export MACHINE="zcu111-zynqmp"
export MACHINE="zcu102-zynqmp"

source poky/oe-init-build-env build

echo "" >> conf/local.conf

echo "USE_XSCT_TARBALL=\"0\"" >> conf/local.conf
echo "XILINX_SDK_TOOLCHAIN=\"/xsct/Vitis/2019.2\"" >> conf/local.conf

echo "DL_DIR ?= \"${DOWNLOADS}\"" >> conf/local.conf
echo "SSTATE_DIR ?= \"${SSTATE}\"" >> conf/local.conf


#echo 'BB_NO_NETWORK += "1"' >> conf/local.conf
# echo 'INHERIT += "own-mirrors"' >> conf/local.conf

# export XILINX_VER_MAIN="2019.2"
# echo 'SOURCE_MIRROR_URL ?= "http://petalinux.xilinx.com/sswreleases/rel-v${XILINX_VER_MAIN}/downloads"' >> conf/local.conf


echo 'BB_GENERATE_MIRROR_TARBALLS += "1"' >> conf/local.conf



# Debug variables
# bitbake -e core-image-minimal |grep USE_XSCT_TARBALL


bitbake core-image-minimal || exit 1


if [[ ! -e "${ROOT}/output/${MACHINE}" ]]
then
    mkdir -p "${ROOT}/output/${MACHINE}"
fi


cp -L ${PWD}/tmp/deploy/images/${MACHINE}/boot.bin          "${ROOT}/output/${MACHINE}/boot.bin"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/boot.scr          "${ROOT}/output/${MACHINE}/boot.scr"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/uEnv.txt          "${ROOT}/output/${MACHINE}/uEnv.txt"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/Image             "${ROOT}/output/${MACHINE}/Image"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/*.bit             "${ROOT}/output/${MACHINE}/"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/system.dtb        "${ROOT}/output/${MACHINE}/system.dtb"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/system.dts        "${ROOT}/output/${MACHINE}/system.dts"
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/*cpio.gz.u-boot   "${ROOT}/output/${MACHINE}/"


# bitbake core-image-minimal -c populate_sdk
# cp -L ${PWD}/tmp/deploy/sdk/*.sh /work/output/


