meta-swid-7
===========

Introduction
------------

This is a short description of the steps to take to build the
BSP-Yocto-Ampliphy-i.MX6-PD22.1.1 BSP with support for the VM-017 phyCAM-M
camera on the phyBOARD-Nunki.

This layer adds the ar0521 driver to the linux kernel and an overlay to activate
the camera on the phyBOARD-Nunki. There is also a small script so setup the
media pipeline (setup-pipeline-vm017).


Note:
To get clean images from the VM-017 sensor on the i.MX 6 the framerate needs to
be reduced to 30 FPS with full resolution. Otherwise the data bandwidth of the
sensor exceeds the bandwidth the i.MX 6 can process. Since the link frequency on
the MIPI bus cannot be reduced any further the framerate must be reduced by
adding additional horizontal blanking in order to give the i.MX 6 more time to
process each line of the image. E.g. with the following command for 8 bit
capture (Make sure to select the correct subdevice).

```
v4l2-ctl -d /dev/v4l-subdev15 -c horizontal_blanking=2270
```

12 Bit mode is not supported on the i.MX 6.

Build
-----
Follow the steps bellow to build the BSP with VM-017 support.

1. Create an empty folder to build the BSP in.
   ```
   host$ mkdir ~/yocto
   host$ cd ~/yocto
   ```

2. Get our phyLinux script to check out the BSP-Yocto-Ampliphy-i.MX6-PD22.1.1 BSP.
   ```
   host$ wget https://download.phytec.de/Software/Linux/Yocto/Tools/phyLinux
   host$ chmod +x phyLinux
   host$ ./phyLinux init -p imx6 -r BSP-Yocto-Ampliphy-i.MX6-PD22.1.1
   ```

3. Clone the meta-swid-7 layer into your sources directory.
   ```
   host$ git clone https://github.com/phytec/meta-swid-7.git sources/meta-swid-7 -b kirkstone
   ```

4. Source the environment.
   ```
   host$ source sources/poky/oe-init-build-env
   ```

5. Enable the newly added layer in your bblayers.conf by adding following line
   to conf/bblayers.conf:
   ```
   BBLAYERS += " ${OEROOT}/../meta-swid-7"
   ```

6. Select machine phyboard-nunki-imx6-1 in conf/local.conf
   ```
   MACHINE ?= "phyboard-nunki-imx6-1"
   ```

7. Build image.
   ```
   host$ bitbake phytec-headless-image
   ```


After that the build image can be found under
`deploy-ampliphy/images/phyboard-nunki-imx6-1/`.
