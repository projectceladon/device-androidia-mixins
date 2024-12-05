# Those 3 lines are required to enable vendor image generation.
# Remove them if vendor partition is not used.
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
VENDOR_PARTITION_SIZE := $(shell echo {{partition_size}}*1048576 | bc)

# vendor_dlkm support
BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm

{{^dynamic-partitions}}
BOARD_VENDORIMAGE_PARTITION_SIZE := $(VENDOR_PARTITION_SIZE)
{{/dynamic-partitions}}
{{#slot-ab}}
AB_OTA_PARTITIONS += vendor
AB_OTA_PARTITIONS += vendor_dlkm
{{/slot-ab}}
