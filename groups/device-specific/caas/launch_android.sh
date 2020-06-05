#!/bin/bash

work_dir=$PWD
scripts_dir=$work_dir/scripts
audio_settings=$scripts_dir/setup_audio_host.sh
start_android_qcow2=$scripts_dir/start_android_qcow2.sh

if [[ $USER == "root" ]];then
        echo "Please run this script without sudo"
        exit -1
fi
$audio_settings setMicGain
echo -e "\n"
sudo -E $start_android_qcow2 "$@"
