# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# Unable to find any files that looked like license statements. Check the accompanying
# documentation and source headers and set LICENSE and LIC_FILES_CHKSUM accordingly.
#
# NOTE: LICENSE is being set to "CLOSED" to allow you to at least start building - if
# this is not accurate with respect to the licensing of the software being built (it
# will not be in most cases) you must specify the correct value before using this
# recipe for anything other than initial testing/development!
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=554c2cf2fbb75ad99545920b6a7440ea"


SRC_URI = "git://git@github.com/otukka/Embedded-app.git;protocol=ssh \
file://0001-remove-xrfdc-include.patch"

# Modify these as desired
#PV = "1.0+git${SRCPV}"
SRCREV = "1ca7918c07727f2d83dcc732863edb4004025f9d"

S = "${WORKDIR}/git"

inherit cmake

# Specify any options you want to pass to cmake using EXTRA_OECMAKE:
EXTRA_OECMAKE = ""




FILES_${PN} = "${bindir}/app"
do_install() {
	install -D -m 0754 ${B}/app ${D}/${bindir}/app
}