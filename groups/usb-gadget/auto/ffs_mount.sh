#!/vendor/bin/sh
DIR="/sys/class/udc/"
if [ -f $DIR ]; then
	mount -t functionfs adb /dev/usb-ffs/adb -o uid=2000,gid=2000  
else
	mount -t functionfs adb /dev/usb-ffs/adb -o uid=2000,gid=2000
fi
