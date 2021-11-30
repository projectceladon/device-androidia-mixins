#!/vendor/bin/sh

# 4G size in kB
SIZE_4G=4194304

mem_size=`cat /proc/meminfo | grep MemTotal | tr -s ' ' | cut -d ' ' -f 2`

if [ "$mem_size" -le "$SIZE_4G" ]
then
    setprop vendor.le_4g_ram 1
else
    setprop vendor.le_4g_ram 0
fi
