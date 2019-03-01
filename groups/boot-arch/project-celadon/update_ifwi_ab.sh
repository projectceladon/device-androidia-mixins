#!/vendor/bin/sh

cp -r /postinstall/firmware /mnt
setprop vendor.ota.update.fw true

exit
