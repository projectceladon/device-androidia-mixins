#!/bin/sh

cpu=`nproc`
mn=`cat /proc/devices | grep msr | cut -d' ' -f1`

i=0
while [ $i -lt $cpu ]
do
  echo $i
  mkdir -p /dev/cpu/${i}/
  cd /dev/cpu/${i}/
  mknod msr c ${mn} ${i}
  cd -
  i=$((i+1))
done
