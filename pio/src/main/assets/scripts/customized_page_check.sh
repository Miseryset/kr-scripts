
dir_name="/sdcard/Android/MiserysetTool"

if [ ! -f ${dir_name}/customizedlayouts.xml ]; then
  mkdir -p ${dir_name}
  cp -f "${START_DIR}/layouts/font_module_build.xml" "${dir_name}/customizedlayouts.xml"
fi