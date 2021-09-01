
# https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/59605045/Adding+an+HDF+to+a+Xilinx+Yocto+Layer : 
# Using a default HDF with a Custom Machine
# If you are a software developer, you may not care about the actual bitstream to get started working with software on an evaluation platform such as the ZCU102.  However, you still need a base HDF to import the PCW configuration for the PS.  Xilinx has default HDFs for each platform on GitHub, but those only match the default machine name.  If you are working with a custom machine configuration, you need to either use a local HDF or trick Yocto into using a compatible HDF.  For instance you could chose a naming convention that incorporates the default machine you are targeting, e.g. example-zcu102-zynmp.conf.  From this name you can extract the default HDF.  The bbappend below shows how you could extend the external-hdf recipe to use one of the default HDFs with your custom machine.  Essentially you are creating a link from your machine to the default machine in the working directory.

MACHINE_BASE = "${@'-'.join(MACHINE.rsplit('-')[-2:])}"

do_install_prepend() {
        if [ "${MACHINE_BASE}" != "${MACHINE}" ] &&
           [ -d ${WORKDIR}/git/${MACHINE_BASE} ]; then
                ln -sf ${MACHINE_BASE} ${WORKDIR}/git/${MACHINE}
        fi
}