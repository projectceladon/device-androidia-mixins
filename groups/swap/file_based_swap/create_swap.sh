#!/vendor/bin/sh

swap_size={{size}}
swap_file={{path}}

dd if=/dev/zero of=$swap_file bs=1024 count=$swap_size
chown system:system $swap_file
chmod 600 $swap_file
mkswap $swap_file
swapon $swap_file

