INSTALLED_ACRNIMAGE_TARGET := $(PRODUCT_OUT)/acrn.img
ACRN_SRC:= $(TOP)/vendor/intel/acrn/acrn.bin
ifeq ($(INTEL_PREBUILT),true)
ACRN_BIN:= $(wildcard $(INTEL_PATH_PREBUILTS)/acrn/acrn.bin)
else
ACRN_BIN:= $(PRODUCT_OUT)/acrn.bin
endif
GENIMAGE := $(INTEL_PATH_BUILD)/GenMbImage.py

$(ACRN_BIN): $(ACRN_SRC)
	$(hide) $(ACP) $(ACRN_SRC) $(ACRN_BIN);
ifneq ($(INTEL_PREBUILT),true)
ifneq ($(INTEL_PATH_PREBUILTS_OUT),)
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)/acrn
	@echo "Copy acrn binaries to $(INTEL_PATH_PREBUILTS_OUT)/acrn"
	$(hide) if [ -n "$(ACRN_BIN)" ]; then \
		$(ACP) $(ACRN_BIN) $(INTEL_PATH_PREBUILTS_OUT)/acrn; \
	fi
endif # INTEL_PATH_PREBUILTS_OUT
endif # INTEL_PREBUILT

ifeq (true,$(BOARD_AVB_ENABLE)) # BOARD_AVB_ENABLE == true
$(INSTALLED_ACRNIMAGE_TARGET): $(ACRN_BIN) $(AVBTOOL) $(GENIMAGE)
	python3 $(GENIMAGE) create -m $< -c "$(ACRN_CMDLINE)" -o $@
	@echo "$(AVBTOOL): add hashfooter to acrn image: $@"
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_ACRNIMAGE_PARTITION_SIZE) \
		--partition_name acrn
INSTALLED_VBMETAIMAGE_TARGET ?= $(PRODUCT_OUT)/vbmeta.img
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_ACRNIMAGE_TARGET)
$(INSTALLED_VBMETAIMAGE_TARGET): $(INSTALLED_ACRNIMAGE_TARGET)
else
$(INSTALLED_ACRNIMAGE_TARGET): $(ACRN_BIN)
	$(hide) $(ACP) $< $@
endif # BOARD_AVB_ENABLE == true

.PHONY: acrnimage
acrnimage: $(INSTALLED_ACRNIMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_ACRNIMAGE_TARGET)

{{^slot-ab}}
# recovery doesn't use acrn
recoveryimage:
{{/slot-ab}}
