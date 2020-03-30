# Those 3 lines are required to enable odm image generation.
# Remove them if odm partition is not used.
TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
ODM_PARTITION_SIZE := $(shell echo {{partition_size}}*1048576 | bc)
BOARD_ODMIMAGE_PARTITION_SIZE := $(ODM_PARTITION_SIZE)
TARGET_USE_ODM := true
{{#slot-ab}}
AB_OTA_PARTITIONS += odm
{{/slot-ab}}
