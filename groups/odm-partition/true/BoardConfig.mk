# Those 3 lines are required to enable odm image generation.
# Remove them if odm partition is not used.
TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
ODM_PARTITION_SIZE := $(shell echo {{partition_size}}*1048576 | bc)

# odm_dlkm support
BOARD_USES_ODM_DLKMIMAGE := true
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm

{{^dynamic-partitions}}
BOARD_ODMIMAGE_PARTITION_SIZE := $(ODM_PARTITION_SIZE)
{{/dynamic-partitions}}
TARGET_USE_ODM := true
{{#slot-ab}}
AB_OTA_PARTITIONS += odm
AB_OTA_PARTITIONS += odm_dlkm
{{/slot-ab}}
