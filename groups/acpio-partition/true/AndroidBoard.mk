ACPIO_SRC :=
ACPIO_OUT := $(PRODUCT_OUT)/acpio
ACPIO_BIN := $(PRODUCT_OUT)/acpio.bin
INSTALLED_ACPIOIMAGE_TARGET := $(PRODUCT_OUT)/acpio.img

MKDTIMG := $(HOST_OUT_EXECUTABLES)/mkdtimg

{{#firststage-mount}}
ACPIO_SRC += $(FIRSTSTAGE_MOUNT_SSDT)
{{/firststage-mount}}

ifneq (,$(ACPIO_SRC))
$(ACPIO_BIN): $(ACPIO_SRC) $(MKDTIMG)
	$(hide) rm -rf $(ACPIO_OUT) && mkdir -p $(ACPIO_OUT)
	$(hide) $(ACP) $(ACPIO_SRC) $(ACPIO_OUT)
	$(hide) $(MKDTIMG) create $@ --dt_type=acpi --page_size=2048 $(ACPIO_OUT)/*

ifeq (true,$(BOARD_AVB_ENABLE)) # BOARD_AVB_ENABLE == true
$(INSTALLED_ACPIOIMAGE_TARGET): $(ACPIO_BIN) $(AVBTOOL)
	$(hide) $(ACP) $< $@
	@echo "$(AVBTOOL): add hashfooter to acpio image: $@"
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_ACPIOIMAGE_PARTITION_SIZE) \
		--partition_name acpio $(INTERNAL_AVB_SIGNING_ARGS)
INSTALLED_VBMETAIMAGE_TARGET ?= $(PRODUCT_OUT)/vbmeta.img
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_ACPIOIMAGE_TARGET)
$(INSTALLED_VBMETAIMAGE_TARGET): $(INSTALLED_ACPIOIMAGE_TARGET)
else
$(INSTALLED_ACPIOIMAGE_TARGET): $(ACPIO_BIN)
	$(hide) $(ACP) $< $@
endif # BOARD_AVB_ENABLE == true

else
$(ACPIO_BIN):
	$(error No source files for acpio.)

$(INSTALLED_ACPIOIMAGE_TARGET): $(ACPIO_BIN)
endif # ACPIO_SRC is not empty

.PHONY: acpioimage
acpioimage: $(INSTALLED_ACPIOIMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_ACPIOIMAGE_TARGET)

{{^slot-ab}}
recoveryimage: $(BOARD_RECOVERY_ACPIO)
{{/slot-ab}}
