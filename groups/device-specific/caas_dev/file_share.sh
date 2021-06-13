#! /system/bin/sh
mount -t 9p -o trans=virtio,version=9p2000.L hostshare /mnt/share
