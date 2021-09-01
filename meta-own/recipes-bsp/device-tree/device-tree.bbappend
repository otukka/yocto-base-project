FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SYSTEM_USER_DTSI ?= "system-user.dtsi"

SRC_URI_append = " file://${SYSTEM_USER_DTSI}"

do_configure_append() {
    cp ${WORKDIR}/${SYSTEM_USER_DTSI} ${B}/device-tree
    echo "/include/ \"${SYSTEM_USER_DTSI}\"" >> ${B}/device-tree/system-top.dts
}


# Revert the dtb-file back to dts-file for debugging purposis.
do_deploy_append() {
    dtc -I dtb -O dts -o  ${DEPLOYDIR}/system.dts ${DEPLOYDIR}/system.dtb
}