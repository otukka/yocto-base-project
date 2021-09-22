#!/bin/bash

COMMAND='''
#!/bin/bash

export MACHINE="zcu102-zynqmp" 

cp pmu_rom_qemu_sha3.elf build/tmp/deploy/images/${MACHINE}/pmu-rom.elf
source poky/oe-init-build-env build




runqemu ${MACHINE}
#runqemu /work/build/tmp/deploy/images/zcu102-zynqmp/core-image-minimal-zcu102-zynqmp-20210916182710.qemuboot.conf
'''


echo ${COMMAND}

# Run yocto build using docker container
docker run -it --rm \
--privileged \
--network=host \
-u root \
-v ${PWD}:/work/ \
-t yoctobuilder \
/bin/bash -c "${COMMAND}" || exit 1
