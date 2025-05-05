FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://imx6-vm017-mipi-0.dtso \
"

DT_OVERLAYS_INSTALL += "imx6-vm017-mipi-0.dtbo"

python do_unpack:append() {
    import shutil, os, re

    dest_dir = d.getVar('DT_FILES_PATH')
    os.makedirs(dest_dir, exist_ok=True)

    src_uri_files = d.getVar("SRC_URI").split()
    for src in src_uri_files:
        if not (match := re.search(r".*://(.*)", src)):
            continue

        src_file = match.group(1)

        if not src_file.endswith("dtso"):
            continue

        dt_file = os.path.join(d.getVar('WORKDIR'), src_file)
        shutil.copy(dt_file, dest_dir)
}
