#!/bin/bash

INSTANCE_NUM=1000
HOSTSFILE=./dnsmasq.hostsfile

rm -f $HOSTSFILE
for i in $(seq 0 $INSTANCE_NUM)
do
    MAC=02:42:ac:64:$(printf "%02x" $(($i / 256))):$(printf "%02x" $(($i % 256)))
    IP=172.100.$((($i + 2) / 256)).$((($i + 2) % 256))
    echo "$MAC,$IP,infinite" >> $HOSTSFILE
done
