FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://setup-pipeline-vm017.sh \
"

do_install:mx6-generic-bsp() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/setup-pipeline-vm017.sh ${D}${bindir}/setup-pipeline-vm017
}
