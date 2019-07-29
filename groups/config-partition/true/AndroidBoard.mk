INSTALLED_CONFIGIMAGE_TARGET := $(PRODUCT_OUT)/config.img

selinux_fc := $(TARGET_ROOT_OUT)/file_contexts.bin

{{^slot-ab}}
OEM_CONFIG_DIR := $(TARGET_ROOT_OUT)/oem_config
RECOVERY_OEM_CONFIG_DIR := $(TARGET_RECOVERY_ROOT_OUT)/oem_config
{{/slot-ab}}
{{#slot-ab}}
OEM_CONFIG_DIR := $(TARGET_ROOT_OUT)/mnt/vendor/oem_config
RECOVERY_OEM_CONFIG_DIR := $(TARGET_RECOVERY_ROOT_OUT)/mnt/vendor/oem_config
{{/slot-ab}}

$(OEM_CONFIG_DIR):
{{^slot-ab}}
	@mkdir -p $(PRODUCT_OUT)/root/oem_config
{{/slot-ab}}
{{#slot-ab}}
	@mkdir -p $(PRODUCT_OUT)/root/mnt/vendor
	@mkdir -p $(PRODUCT_OUT)/root/mnt/vendor/oem_config
{{/slot-ab}}
$(RECOVERY_OEM_CONFIG_DIR):
{{^slot-ab}}
	@mkdir -p $(PRODUCT_OUT)/recovery/root/oem_config
{{/slot-ab}}
{{#slot-ab}}
	@mkdir -p $(PRODUCT_OUT)/recovery/root/mnt/vendor
	@mkdir -p $(PRODUCT_OUT)/recovery/root/mnt/vendor/oem_config
{{/slot-ab}}

$(PRODUCT_OUT)/ramdisk.img: $(OEM_CONFIG_DIR) $(RECOVERY_OEM_CONFIG_DIR)

$(INSTALLED_CONFIGIMAGE_TARGET) : PRIVATE_SELINUX_FC := $(selinux_fc)
$(INSTALLED_CONFIGIMAGE_TARGET) : $(MKEXTUSERIMG) $(MAKE_EXT4FS) $(E2FSCK) $(selinux_fc) $(INSTALLED_BOOTIMAGE_TARGET) $(OEM_CONFIG_DIR) $(RECOVERY_OEM_CONFIG_DIR)
	$(call pretty,"Target config fs image: $(INSTALLED_CONFIGIMAGE_TARGET)")
	@mkdir -p $(PRODUCT_OUT)/config
	$(hide)	PATH=$(HOST_OUT_EXECUTABLES):$$PATH \
		$(MKEXTUSERIMG) -s \
		$(PRODUCT_OUT)/config \
		$(PRODUCT_OUT)/config.img \
		ext4 \
		oem_config \
		$(BOARD_CONFIGIMAGE_PARTITION_SIZE) \
		$(PRIVATE_SELINUX_FC)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_CONFIGIMAGE_TARGET)

selinux_fc :=
