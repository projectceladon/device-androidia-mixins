BOARD_PREBUILT_VENDOR_BOOT_DIR := $(TARGET_DEVICE_DIR)/vendor-boot-ramdisk
INTERNAL_VENDOR_RAMDISK_TARGET := $(call intermediates-dir-for,PACKAGING,vendor-boot)/vendor-ramdisk.cpio.gz

.PHONY: vendor_boot_prebuilt
vendor_boot_prebuilt:
	$(hide) rm -rf $(TARGET_VENDOR_RAMDISK_OUT)/*
	$(hide) mkdir -p $(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk
	$(hide) if [ -d "$(BOARD_PREBUILT_VENDOR_BOOT_DIR)" ]; then \
		$(ACP) -r $(BOARD_PREBUILT_VENDOR_BOOT_DIR)/* $(TARGET_VENDOR_RAMDISK_OUT)/; \
	fi

$(INTERNAL_VENDOR_RAMDISK_TARGET): vendor_boot_prebuilt
