#! /bin/bash
set -e

self_name() {
  echo "${0##*/}"
}

JETHUB_J80=jethub-j80
JETHUB_J100=jethub-j100

if [[ $# -lt 2 ]]; then
  echo "Script to import prebuilt U-Boot files into this project."
  echo
  echo "Usage: $(self_name) <import_dir> <$JETHUB_J80|$JETHUB_J100> [hassos]"
  echo
  echo "example 1: $(self_name) /opt/u-boot $JETHUB_J80"
  echo "example 2: $(self_name) /home/user/src/u-boot $JETHUB_J100"
  echo

  exit 1
fi

IMPORT_DIR=$1
PLATFORM=$2

case $PLATFORM in
	"$JETHUB_J80" )
		;;
	"$JETHUB_J100" )
		;;
	* )
		echo "Incorrect second argument"
		exit 2
		;;
esac

if [ -z "$3" ]; then
PLATFORM=$2
else
PLATFORM=hassos/$2
fi


cp -fv "$IMPORT_DIR"/{\
bl33/build/include/generated/version_autogenerated.h,\
bl33/build/include/generated/timestamp_autogenerated.h,\
bl33/build/include/config/uboot.release,\
bl33/build/.config,\
build/u-boot.bin,\
build/u-boot.bin.usb.bl2,\
build/u-boot.bin.usb.tpl} \
"$PLATFORM/"