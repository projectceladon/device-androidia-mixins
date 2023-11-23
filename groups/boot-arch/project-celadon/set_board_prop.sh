#!/vendor/bin/sh

#set board_name

#for i in $(cat /proc/cmdline)
#do
#       aa=`echo $i | sed -n '/board_name=/p'`
#       if [ -n "$aa" ]
#       then
#               board_name=`echo $aa | sed  -e '/board_name=/s/board_name=\(.*\)/\1/'`
#       fi
#done
board_name=`getprop ro.boot.hw_id`

if [ -z "$board_name" ]
then
        setprop vendor.product.board_type "celadon"
elif [ "$board_name" == "intel_poc" ] || [ "$board_name" == "mbl_rvp" ]
then
        setprop vendor.product.board_type "celadon"
        setprop vendor.product.board_name "$board_name"
elif [ "$board_name" == "blizzard_vm1" ] || [ "$board_name" == "blizzard_vm2" ] || [ "$board_name" == "blizzard_vm3" ]
then
        setprop vendor.product.board_type "blizzard"
        setprop vendor.product.board_name "$board_name"
else
        setprop vendor.product.board_type "$board_name"
        setprop vendor.product.board_name "$board_name"
fi
