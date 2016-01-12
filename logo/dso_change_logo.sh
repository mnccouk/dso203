#!/bin/bash

device=/dev/sdX
mount_point=/mnt/usb
logo=~/dso203/logo/xil.bmp

# configuration ends here

if [ !-f$logo ]; then
  echo "No such file: $logo"
  echo
  echo "Edit `basename $0` to set file and device"
  exit 1
fi

function mount_device {
  while [ 1 ]; do
    sleep 1
    echo -n .
    mount $device $mount_point 2> /dev/null
    if [ $? = 0 ]; then
      break
    fi
  done
  echo
  ls $mount_point
}

mount_device
echo 0x0803D800 > $mount_point/LOGO.ADR
umount $mount_point

mount_device
cp $logo $mount_point/LOGO_NEW.BIN
umount $mount_point

mount_device
umount $mount_point
