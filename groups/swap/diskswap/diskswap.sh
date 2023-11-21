#!/vendor/bin/sh

# Look for partition with label ANDROID-SWAP
# exit if swap partition not exist
swapinblk=$(/bin/blkid|grep -w  "LABEL=\"ANDROID-SWAP\"")
filter1=${swapinblk##*/}
disk_part=${filter1%%:*}
if [ -z $disk_part ]; then
  echo "ANDROID-SWAP partition not found ($disk_part)"
  exit
fi

# Check if the swap_disk_path file exists
# exit since there is no point in continuing
swapfile=swapfile
swap_disk_path=/dev/block/$disk_part
swap_mount_path=/mnt/swap
if [ ! -e $swap_disk_path ]; then
  exit
fi

# Check if the swap_mount_path file exists.
# Create mount dir if not exist
if [ ! -e $swap_mount_path ]; then
  mkdir -p $swap_mount_path
fi

# Check if swap partition mounted or not
swap_mount_point=$(df | grep -i $swap_disk_path | awk '{print $1}')
swap_mount_dir=$(df | grep -i $swap_mount_path | awk '{print $6}')

if [ $swap_mount_point == $swap_disk_path ]; then
  echo "The mount point $swap_mount_point is mounted and the file-system type is $swap_mount_dir."
else
  # echo "The mount point: $swap_disk_path is not mounted at $swap_mount_path"
  mount $swap_disk_path $swap_mount_path
fi

# Check if swap disk & its size exist or not
disk_size=$(grep -w $disk_part /proc/partitions |awk '{print $3}')
reserve=102400
swap_size=$(($disk_size - $reserve))

# create and format swap file
swap_file=$swap_mount_path/$swapfile
dd if=/dev/zero of=$swap_file bs=1024 count=$swap_size

# set file permissions
chmod 600 $swap_file
chown system:system $swap_file

# format as swap file using mkswap.
mkswap $swap_file

# activate swap
swapon $swap_file
