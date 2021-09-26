#!/vendor/bin/sh

until mount |grep "/mnt/user/0/emulated/0/Android/obb"
do
	sleep 1s
done

setprop vendor.intel.mount_share 1
