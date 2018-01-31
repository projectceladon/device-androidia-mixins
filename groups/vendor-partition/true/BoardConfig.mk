# Those 3 lines are required to enable vendor image generation.
# Remove them if vendor partition is not used.
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_PARTITION_SIZE := 1572864000
ifeq ($(SPARSE_IMG),true)
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
else
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := squashfs
endif
BOARD_FLASHFILES += $(PRODUCT_OUT)/vendor.img
