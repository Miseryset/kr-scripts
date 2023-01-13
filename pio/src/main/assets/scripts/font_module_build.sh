
echo "模板模块路径：$font_module "
echo ""
echo "字重 100 - 淡体 Thin /Hairline 文件：$fontw_thin "
echo "字重 200 - 特细 Extra-Light / Ultra-Light 文件：$fontw_extralight "
echo "字重 300 - 细体 Light 文件：$fontw_light "
echo "字重 400 - 标准 Regular / Normal / Book / Plain 文件：$fontw_regular "
echo "字重 500 - 适中 Medium 文件：$fontw_medium "
echo "字重 600 - 次粗 Demi-Bold / Semi-Bold 文件：$fontw_demibold "
echo "字重 700 - 粗体 Bold 文件：$fontw_bold "
echo "字重 800 - 特粗 Extra-bold / Extra 文件：$fontw_extrabold "
echo "字重 900 - 浓体 Black / Heavy 文件：$fontw_black "
echo ""
echo "生成的字体模块保存文件夹为：$save_folder"
function num_to_YN(){
  if [[ $2 == 1 ]]; then
    echo "$1 是"
  elif [[ $2 == 0 ]]; then
    echo "$1 否"
  fi
}
num_to_YN "删除原字体文件？" "$isdelete_of"
num_to_YN "直接刷入？" "$isflash"
echo "字体id：$font_id"
echo "字体名称：$font_name"
echo ""

workdir='/sdcard/tmp_3.1415926'
finish(){
    echo "$1"
    rm -rf $workdir
    exit 0
}
[ ! -d $workdir ] && mkdir -p $workdir
[ ! -e $font_module ] && finish "模块模板不存在"
unzip -o $font_module -d $workdir

for ghvb in `seq 9`
do
  rm -f ${workdir}/system/fonts/fontw${ghvb}.ttf
done

[[ $fontw_thin != "" ]] && cp -f $fontw_thin $workdir/system/fonts/fontw1.ttf
[[ $fontw_extralight != "" ]] && cp -f $fontw_extralight $workdir/system/fonts/fontw2.ttf
[[ $fontw_light != "" ]] && cp -f $fontw_light $workdir/system/fonts/fontw3.ttf
[[ $fontw_regular != "" ]] && cp -f $fontw_regular $workdir/system/fonts/fontw4.ttf
[[ $fontw_medium != "" ]] && cp -f $fontw_medium $workdir/system/fonts/fontw5.ttf
[[ $fontw_demibold != "" ]] && cp -f $fontw_demibold $workdir/system/fonts/fontw6.ttf
[[ $fontw_bold != "" ]] && cp -f $fontw_bold $workdir/system/fonts/fontw7.ttf
[[ $fontw_extrabold != "" ]] && cp -f $fontw_extrabold $workdir/system/fonts/fontw8.ttf
[[ $fontw_black != "" ]] && cp -f $fontw_black $workdir/system/fonts/fontw9.ttf

if [[ $isdelete_of == 1 ]]; then
  for fontw in $fontw_thin $fontw_extralight $fontw_light $fontw_regular $fontw_medium $fontw_demibold $fontw_bold $fontw_extrabold $fontw_black
  do
	  rm -f $fontw
	done
fi

echo "id=Font_$font_id
name=$font_name
version=1
versionCode=1
author=MiserysetTool by lxgw_template
description= $font_name 字体，制作时间 $(date +%F) $(date +%T) " > $workdir/module.prop

cd $workdir
rm -rf $save_folder/$font_name.zip
zip -r $save_folder/$font_name.zip *

if [[ $isflash == 1 ]]; then
    magisk --install-module $save_folder/$font_name.zip
fi

finish "完成"
