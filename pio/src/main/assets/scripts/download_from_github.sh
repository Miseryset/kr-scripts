tag="latest"
#tag="tags/Prerelease-Alpha"

cacert_file="${START_DIR}/kr-script/custom/other/cacert.pem"
url=$(curl -s --cacert "${cacert_file}" ${1}/${tag} \
| grep "${2}" \
| cut -d : -f 2,3 \
| tr -d \")

url=${url#*https}

curl --cacert "${cacert_file}" -L "https${url}" -o ${3}
download_path="/sdcard/Download"

if [ -e ${3} ]; then
  mvg -bfg ${3} ${download_path}/${3}
  if [ -e ${download_path}/${3} ]; then
    echo "已下载${3}"
  fi
fi