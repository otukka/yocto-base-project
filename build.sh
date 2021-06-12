#!/bin/bash



DOWNLOADS="/work/downloads/"
SSTATE="/work/sstate-cache"

export LAYER="own"



export TEMPLATECONF="${PWD}/meta-own/conf/"
export MACHINE="zcu102-zynqmp"
source poky/oe-init-build-env build

echo "USE_XSCT_TARBALL=\"0\"" >> conf/local.conf
echo "XILINX_SDK_TOOLCHAIN=\"/xsct/Vitis/2019.2\"" >> conf/local.conf

echo "DL_DIR ?= \"${DOWNLOADS}\"" >> conf/local.conf
echo "SSTATE_DIR ?= \"${SSTATE}\"" >> conf/local.conf


#echo 'BB_NO_NETWORK += "1"' >> conf/local.conf
#echo 'INHERIT += "own-mirrors"' >> conf/local.conf
echo 'BB_GENERATE_MIRROR_TARBALLS += "1"' >> conf/local.conf

cd ..
bitbake-layers create-layer meta-$LAYER

cd build
bitbake-layers add-layer ../meta-$LAYER


bitbake core-image-minimal


cp -L ${PWD}/tmp/deploy/images/${MACHINE}/boot.bin /work/output/boot.bin
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/boot.scr /work/output/boot.scr
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/uEnv.txt /work/output/uEnv.txt
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/Image /work/output/Image
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/*.bit /work/output/
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/system.dtb /work/output/system.dtb
cp -L ${PWD}/tmp/deploy/images/${MACHINE}/*cpio.gz.u-boot /work/output/
cp -L ${PWD}/tmp/deploy/sdk/*.sh /work/output/


bitbake core-image-minimal -c populate_sdk




