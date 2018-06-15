gptimage_size ?= {{{size}}}

raw_config := none
raw_factory := none
tos_bin := none
multiboot_bin := none

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

$(GPTIMAGE_BIN): \
	bootloader \
	bootimage \
	{{^slot-ab}}
	recoveryimage \
	cacheimage \
	{{/slot-ab}}
	systemimage \
	{{#avb}}
	vbmetaimage \
	{{/avb}}
    {{#vendor-partition}}
	vendorimage \
    {{/vendor-partition}}
	$(SIMG2IMG) \
	$(raw_config) \
	$(raw_factory)

	$(hide) rm -f $(INSTALLED_SYSTEMIMAGE).raw
	$(hide) rm -f $(INSTALLED_USERDATAIMAGE_TARGET).raw
	{{^slot-ab}}
	$(hide) rm -f $(INSTALLED_CACHEIMAGE_TARGET).raw
	{{/slot-ab}}

	$(MAKE_EXT4FS) \
		-l $(BOARD_USERDATAIMAGE_PARTITION_SIZE) -L data \
		$(PRODUCT_OUT)/userdata.dummy

	$(SIMG2IMG) $(INSTALLED_SYSTEMIMAGE) $(INSTALLED_SYSTEMIMAGE).raw
	{{^slot-ab}}
	$(SIMG2IMG) $(INSTALLED_CACHEIMAGE_TARGET) $(INSTALLED_CACHEIMAGE_TARGET).raw
	{{/slot-ab}}
    {{#vendor-partition}}
	$(SIMG2IMG) $(INSTALLED_VENDORIMAGE_TARGET) $(INSTALLED_VENDORIMAGE_TARGET).raw
    {{/vendor-partition}}

	$(INTEL_PATH_BUILD)/create_gpt_image.py \
		--create $@ \
		--block $(BOARD_FLASH_BLOCK_SIZE) \
		--table $(TARGET_DEVICE_DIR)/gpt.ini \
		--size $(gptimage_size) \
		--bootloader $(bootloader_bin) \
		--bootloader2 $(bootloader_bin) \
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
		--system $(INSTALLED_SYSTEMIMAGE).raw \
        {{#vendor-partition}}
		--vendor $(INSTALLED_VENDORIMAGE_TARGET).raw \
        {{/vendor-partition}}
		--data $(PRODUCT_OUT)/userdata.dummy \
		--config $(raw_config) \
		--factory $(raw_factory)


.PHONY: gptimage
gptimage: $(GPTIMAGE_BIN)
