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
	{{#avb}}
	vbmetaimage \
	{{/avb}}
	{{^dynamic-partitions}}
	systemimage \
  {{#vendor-partition}}
	vendorimage \
	{{/vendor-partition}}
	{{#product-partition}}
	productimage \
	{{/product-partition}}
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
		{{#avb}}
		--vbmeta $(INSTALLED_VBMETAIMAGE_TARGET) \
		{{/avb}}
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
		--config $(raw_config) \
		--factory $(raw_factory)

.PHONY: gptimage
gptimage: $(GPTIMAGE_BIN)
