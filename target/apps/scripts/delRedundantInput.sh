#! /system/bin/sh

eventDir="/dev/input"
inputConfDir="/ipc/config/input/input"
indexAndroid=$(getprop sys.container.id)
eventId=""
i=2

getInputEvent(){
    line=$(cat $inputConfDir$indexAndroid)
    if [[ $(echo $line | grep "virtual") != "" ]];then
        result=$(find /sys$line -name 'event*')
    else
        result=$(find /sys/devices$line -name 'event*')
    fi
    if [ "$result" ];then
        eventId=${result##*/}
    fi
}

getInputEvent

for androidDev in "$eventDir"/*
do
  if [[ $(echo $androidDev | grep "$eventId") == "" ]]
  then
     rm $androidDev
     i=$(($i+1))

  fi
done
