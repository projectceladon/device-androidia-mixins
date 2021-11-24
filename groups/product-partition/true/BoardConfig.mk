# Those 3 lines are required to enable product image generation.
# Remove them if product partition is not used.
TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := {{system_fs}}
PRODUCT_PARTITION_SIZE := $(shell echo {{partition_size}}*1048576 | bc)
{{^dynamic-partitions}}
BOARD_PRODUCTIMAGE_PARTITION_SIZE := $(PRODUCT_PARTITION_SIZE)
{{/dynamic-partitions}}
TARGET_USE_PRODUCT := true
{{#slot-ab}}
AB_OTA_PARTITIONS += product
{{/slot-ab}}
BOARD_EXT4_SHARE_DUP_BLOCKS := true
