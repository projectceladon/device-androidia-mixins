BOARD_CONFIGIMAGE_PARTITION_SIZE := 8388608
BOARD_FLASHFILES += $(PRODUCT_OUT)/config.img
BOARD_SEPOLICY_M4DEFS += module_config_partition=true
BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy/config-partition
