#!/vendor/bin/sh

MODEL_NAME=`cat /proc/cpuinfo | grep -i -m 1 "model name" | cut -d ':' -f 2 | cut -d '@' -f 1`

arr=($MODEL_NAME)

for w in "${arr[@]}"; do
        if [ $(echo $w | grep -c "-") -gt 0 ]; then
                MODEL_NAME=$w
        fi
done

setprop vendor.cpu.model_name "$MODEL_NAME"
