# Those 3 lines are required to enable product image generation.
# Remove them if product partition is not used.
TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
BOARD_PRODUCTIMAGE_PARTITION_SIZE := $(shell echo {{partition_size}}*1048576 | bc)
{{#slot-ab}}
AB_OTA_PARTITIONS += product
{{/slot-ab}}
