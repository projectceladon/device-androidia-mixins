ACPI_SRC :=
ACPI_OUT := $(PRODUCT_OUT)/acpi
INSTALLED_ACPIIMAGE_TARGET := $(PRODUCT_OUT)/acpi.img

MKDTIMG := $(HOST_OUT_EXECUTABLES)/mkdtimg

{{#firststage-mount}}
ACPI_SRC += $(FIRSTSTAGE_MOUNT_SSDT)
{{/firststage-mount}}

ifneq ($(ACPI_SRC),)
$(INSTALLED_ACPIIMAGE_TARGET): $(ACPI_SRC) $(MKDTIMG) {{#avb}}$(AVBTOOL){{/avb}}
	$(hide) rm -rf $(ACPI_OUT) && mkdir -p $(ACPI_OUT)
	$(ACP) $(ACPI_SRC) $(ACPI_OUT)
	$(MKDTIMG) create $@ --dt_type=acpi --page_size=2048 $(ACPI_OUT)/*
{{#avb}}
	@echo "$(AVBTOOL): add hashfooter to acpi image: $@"
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_ACPIIMAGE_PARTITION_SIZE) \
		--partition_name acpi $(INTERNAL_AVB_SIGNING_ARGS)
INSTALLED_VBMETAIMAGE_TARGET ?= $(PRODUCT_OUT)/vbmeta.img
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_ACPIIMAGE_TARGET)
$(INSTALLED_VBMETAIMAGE_TARGET): $(INSTALLED_ACPIIMAGE_TARGET)
{{/avb}}
else
$(INSTALLED_ACPIIMAGE_TARGET):
	$(error No source files for acpi image.)
endif

.PHONY: acpiimage
acpiimage: $(INSTALLED_ACPIIMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_ACPIIMAGE_TARGET)
