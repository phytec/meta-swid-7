FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-media-i2c-Port-ar0521-driver-from-linux-phytec-imx-v.patch \
    file://ar0521.cfg \
"
