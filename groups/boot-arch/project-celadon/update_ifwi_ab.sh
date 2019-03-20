#!/vendor/bin/sh

KF_UPDATE_FILE="/postinstall/firmware/kernelflinger.efi"
BIOS_UPDATE_FILE="/postinstall/firmware/BIOSUPDATE.fv"
DEV_PATH="/dev/block/by-name/bootloader"
MOUNT_POINT="/bootloader"
KF_DESTINATION_FILE="/bootloader/EFI/BOOT/kernelflinger_new.efi"
BIOS_UPDATE_DESTINATION_FILE="/bootloader/BIOSUPDATE.fv"
is_exist_efi=0
is_exist_bios=0

if [ -f ${KF_UPDATE_FILE} ]; then
    is_exist_efi=1
fi
if [ -f ${BIOS_UPDATE_FILE} ]; then
   is_exist_bios=1
fi

if [[ $is_exist_efi -eq 0 && $is_exist_efi -eq 0 ]]; then
    echo "No file to be copied."
    exit -1
fi

mount -t vfat $DEV_PATH $MOUNT_POINT
if [ $? != 0 ]; then
    echo "Cannot mount $MOUNT_POINT"
    exit -2;
fi

if [ $is_exist_efi -eq 1 ]; then
   cp $KF_UPDATE_FILE $KF_DESTINATION_FILE
   if [ $? != 0 ]; then
       echo "Cannot copy $KF_UPDATE_FILE"
       exit -3;
   fi
fi

if [ $is_exist_bios -eq 1 ]; then
   cp $BIOS_UPDATE_FILE $BIOS_UPDATE_DESTINATION_FILE
   if [ $? != 0 ]; then
       echo "Cannot copy $BIOS_UPDATE_FILE"
       exit -4;
   fi
fi

umount $MOUNT_POINT

echo "EFI copy OK"
exit 0
