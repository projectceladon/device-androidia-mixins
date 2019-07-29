BOARD_FIRSTSTAGE_MOUNT_ENABLE := true
{{^dynamic-partitions}}
BOARD_KERNEL_CMDLINE += androidboot.android_dt_dir=/sys/bus/platform/devices/ANDR0001:00/properties/android/
{{/dynamic-partitions}}
FIRSTSTAGE_MOUNT_SSDT = $(PRODUCT_OUT)/firststage-mount.aml
