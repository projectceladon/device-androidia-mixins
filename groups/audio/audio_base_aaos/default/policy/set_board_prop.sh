#!/vendor/bin/sh

board_type=`getprop ro.boot.audio_type | cut -d, -f1`
board_name=`getprop ro.boot.audio_type | cut -d, -f2`

if [ -z "$board_name" ]
then
        setprop vendor.audio.board_type "celadon"
else
        setprop vendor.audio.board_type $board_type
fi

setprop vendor.audio.board_name "$board_name"
