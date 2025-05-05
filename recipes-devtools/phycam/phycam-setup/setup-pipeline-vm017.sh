#!/bin/sh

FMT="SGRBG8_1X8"
CAP_RES="2592x1944"
SEN_RES="2592x1944"
OFFSET="(4,4)"


media-ctl -r
media-ctl -l "'ar0521 0-0036':0->'imx6-mipi-csi2':0[1]"
media-ctl -l "'imx6-mipi-csi2':1->'ipu1_csi0_mux':0[1]"
media-ctl -l "'ipu1_csi0_mux':2->'ipu1_csi0':0[1]"
media-ctl -l "'ipu1_csi0':2->'ipu1_csi0 capture':0[1]"

media-ctl -V "'ar0521 0-0036':0[fmt:${FMT}/${CAP_RES} ${OFFSET}/${SEN_RES} field:none]"
media-ctl -V "'imx6-mipi-csi2':0 [fmt:${FMT}/${CAP_RES} field:none]"
media-ctl -V "'ipu1_csi0_mux':0 [fmt:${FMT}/${CAP_RES} field:none]"
media-ctl -V "'ipu1_csi0':0 [fmt:${FMT}/${CAP_RES} field:none]"

v4l2-ctl -d /dev/v4l-subdev15 -c horizontal_blanking=2270
