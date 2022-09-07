gptimage_size ?= {{{size}}}

raw_config := none
raw_factory := none
tos_bin := none
multiboot_bin := none
raw_product := none
raw_odm := none
raw_acpi := none
raw_acpio := none

.PHONY: none
none: ;

.PHONY: $(INSTALLED_CONFIGIMAGE_TARGET).raw
$(INSTALLED_CONFIGIMAGE_TARGET).raw: $(INSTALLED_CONFIGIMAGE_TARGET) $(SIMG2IMG)
	$(SIMG2IMG) $< $@

.PHONY: $(INSTALLED_FACTORYIMAGE_TARGET).raw
$(INSTALLED_FACTORYIMAGE_TARGET).raw: $(INSTALLED_FACTORYIMAGE_TARGET) $(SIMG2IMG)
	$(SIMG2IMG) $< $@

ifdef INSTALLED_CONFIGIMAGE_TARGET
raw_config := $(INSTALLED_CONFIGIMAGE_TARGET).raw
endif

ifdef INSTALLED_FACTORYIMAGE_TARGET
raw_factory := $(INSTALLED_FACTORYIMAGE_TARGET).raw
endif

ifdef INSTALLED_PRODUCTIMAGE_TARGET
raw_product := $(INSTALLED_PRODUCTIMAGE_TARGET).raw
endif

.PHONY: $(GPTIMAGE_BIN)
ifeq ($(strip $(TARGET_USE_TRUSTY)),true)
ifeq ($(strip $(TARGET_USE_MULTIBOOT)),true)
$(GPTIMAGE_BIN): tosimage multiboot
multiboot_bin = $(INSTALLED_MULTIBOOT_IMAGE_TARGET)
else
$(GPTIMAGE_BIN): tosimage
endif
tos_bin = $(INSTALLED_TOS_IMAGE_TARGET)
endif

{{#odm-partition}}
ifdef INSTALLED_ODMIMAGE_TARGET
raw_odm := $(INSTALLED_ODMIMAGE_TARGET).raw
$(GPTIMAGE_BIN): odmimage $(SIMG2IMG)
	$(SIMG2IMG) $(INSTALLED_ODMIMAGE_TARGET) $(INSTALLED_ODMIMAGE_TARGET).raw
endif
{{/odm-partition}}

{{#acpi-partition}}
ifdef INSTALLED_ACPIIMAGE_TARGET
raw_acpi := $(INSTALLED_ACPIIMAGE_TARGET)
$(ACRN_GPTIMAGE_BIN): acpiimage
endif
{{/acpi-partition}}

{{#acpio-partition}}
ifdef INSTALLED_ACPIOIMAGE_TARGET
raw_acpio := $(INSTALLED_ACPIOIMAGE_TARGET)
$(ACRN_GPTIMAGE_BIN): acpioimage
endif
{{/acpio-partition}}

$(GPTIMAGE_BIN): \
	bootloader \
	bootimage \
	{{^slot-ab}}
	recoveryimage \
	cacheimage \
	{{/slot-ab}}
	vbmetaimage \
	{{^dynamic-partitions}}
	systemimage \
	{{#vendor-partition}}
	vendorimage \
	{{/vendor-partition}}
	{{#product-partition}}
	productimage \
	{{/product-partition}}
	{{#odm-partition}}
	odmimage \
	{{/odm-partition}}
	{{/dynamic-partitions}}
	{{#dynamic-partitions}}
	superimage \
	{{/dynamic-partitions}}
	$(SIMG2IMG) \
	$(raw_config) \
	$(raw_factory)

	$(hide) rm -f $(INSTALLED_SYSTEMIMAGE).raw
	$(hide) rm -f $(INSTALLED_USERDATAIMAGE_TARGET).raw
	{{^slot-ab}}
	$(hide) rm -f $(INSTALLED_CACHEIMAGE_TARGET).raw
	{{/slot-ab}}

	{{^slot-ab}}
	$(SIMG2IMG) $(INSTALLED_CACHEIMAGE_TARGET) $(INSTALLED_CACHEIMAGE_TARGET).raw
	{{/slot-ab}}
	{{^dynamic-partitions}}
	$(SIMG2IMG) $(INSTALLED_SYSTEMIMAGE) $(INSTALLED_SYSTEMIMAGE).raw
	{{#vendor-partition}}
	$(SIMG2IMG) $(INSTALLED_VENDORIMAGE_TARGET) $(INSTALLED_VENDORIMAGE_TARGET).raw
	{{/vendor-partition}}
	{{#product-partition}}
	$(SIMG2IMG) $(INSTALLED_PRODUCTIMAGE_TARGET) $(INSTALLED_PRODUCTIMAGE_TARGET).raw
	{{/product-partition}}
	{{#odm-partition}}
	$(SIMG2IMG) $(INSTALLED_ODMIMAGE_TARGET) $(INSTALLED_ODMIMAGE_TARGET).raw
	{{/odm-partition}}
	{{/dynamic-partitions}}
	{{#dynamic-partitions}}
	$(SIMG2IMG) $(INSTALLED_SUPERIMAGE_TARGET) $(INSTALLED_SUPERIMAGE_TARGET).raw
	{{/dynamic-partitions}}

	$(INTEL_PATH_BUILD)/create_gpt_image.py \
		--create $@ \
		--block $(BOARD_FLASH_BLOCK_SIZE) \
		--table $(BOARD_GPT_INI) \
		--size $(gptimage_size) \
		{{#bootloader_slot_ab}}
		--esp $(esp_bin) \
		{{/bootloader_slot_ab}}
		--bootloader $(bootloader_bin) \
		--tos $(tos_bin) \
		--multiboot $(multiboot_bin) \
		--boot $(INSTALLED_BOOTIMAGE_TARGET) \
		{{^slot-ab}}
		--recovery $(INSTALLED_RECOVERYIMAGE_TARGET) \
		--cache $(INSTALLED_CACHEIMAGE_TARGET).raw \
		{{/slot-ab}}
		--vbmeta $(INSTALLED_VBMETAIMAGE_TARGET) \
	{{^dynamic-partitions}}
		--system $(INSTALLED_SYSTEMIMAGE).raw \
	{{#vendor-partition}}
		--vendor $(INSTALLED_VENDORIMAGE_TARGET).raw \
	{{/vendor-partition}}
	{{#product-partition}}
		--product $(raw_product) \
	{{/product-partition}}
	{{#odm-partition}}
		--odm $(raw_odm) \
	{{/odm-partition}}
	{{/dynamic-partitions}}
	{{#dynamic-partitions}}
		--super $(INSTALLED_SUPERIMAGE_TARGET).raw \
	{{/dynamic-partitions}}
	{{#acpi-partition}}
		--acpi $(raw_acpi) \
	{{/acpi-partition}}
	{{#acpio-partition}}
		--acpio $(raw_acpio) \
	{{/acpio-partition}}
	{{#vendor-boot}}
		--vendor_boot $(INSTALLED_VENDOR_BOOTIMAGE_TARGET) \
	{{/vendor-boot}}
		--config $(raw_config) \
		--factory $(raw_factory)

.PHONY: gptimage
gptimage: $(GPTIMAGE_BIN)

VIRTUAL_BOX_MANAGER_SYSTEM_DISK_PTIONS := --uuid "{b7bcc4dc-6e34-4b9f-ad81-9a94a6e75d3d}"
VIRTUAL_BOX_MANAGER := device/tencent/tools/vbox-img
INSTALLED_ANDROID_IMAGE_SYSTEM_TARGET := $(PRODUCT_OUT)/caas.img
INSTALLED_VBOX_SYSTEM_DISK_IMAGE_TARGET := $(PRODUCT_OUT)/caas.vdi
$(INSTALLED_VBOX_SYSTEM_DISK_IMAGE_TARGET): $(INSTALLED_ANDROID_IMAGE_SYSTEM_TARGET)
	$(hide) rm -f $@
	$(hide) $(VIRTUAL_BOX_MANAGER) \
		convert --srcfilename $^\
		--dstfilename $@ \
		--srcformat RAW --dstformat VDI
	$(hide) $(VIRTUAL_BOX_MANAGER) \
		setuuid --filename $@ \
		$(VIRTUAL_BOX_MANAGER_SYSTEM_DISK_PTIONS)
	@echo "Done with VirtualBox bootable system-disk image -[ $@ ]-"

.PHONY: gptimage_vdi
gptimage_vdi: $(INSTALLED_VBOX_SYSTEM_DISK_IMAGE_TARGET)
