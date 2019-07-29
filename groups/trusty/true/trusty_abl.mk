IAS_IMAGE_APP := $(HOST_OUT_EXECUTABLES)/ias_image_app
IAS_IMAGE_SIGNER := $(HOST_OUT_EXECUTABLES)/ias_image_signer

SIGNING_KEY := $(ABL_OS_KERNEL_KEY).pk8
SIGNING_CERT := $(ABL_OS_KERNEL_KEY).x509.pem

IMAGE_TYPE := 0x40300

INSTALLED_MULTIBOOT_IMAGE_TARGET := $(PRODUCT_OUT)/multiboot.img
INSTALLED_TOS_IMAGE_TARGET := $(PRODUCT_OUT)/tos.img

multiboot: $(INSTALLED_MULTIBOOT_IMAGE_TARGET)

ifeq ($(INTEL_PREBUILT), true)
$(INSTALLED_MULTIBOOT_IMAGE_TARGET):
	$(hide) (cp $(INTEL_PATH_PREBUILTS)/multiboot.img $(INSTALLED_MULTIBOOT_IMAGE_TARGET))
else
ifeq ($(wildcard $(EVMM_PREBUILT)), )
$(INSTALLED_MULTIBOOT_IMAGE_TARGET): $(EVMM_PKG) $(IAS_IMAGE_APP) $(IAS_IMAGE_SIGNER)
	$(IAS_IMAGE_APP) create -o $(@:.img=.img_unsigned) -i $(IMAGE_TYPE) $(EVMM_PKG)
	$(IAS_IMAGE_SIGNER) $(@:.img=.img_unsigned) $(SIGNING_KEY) $(SIGNING_CERT) $@
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) (cp $@ $(INTEL_PATH_PREBUILTS_OUT))
	@echo "Multiboot ABL image successfully generated at $(PRODUCT_OUT)/multiboot.img"
else
$(INSTALLED_MULTIBOOT_IMAGE_TARGET):
	@echo "Use prebuilt multiboot image $(EVMM_PREBUILT)"
	$(hide) (cp $(EVMM_PREBUILT) $(INSTALLED_MULTIBOOT_IMAGE_TARGET))
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) (cp $@ $(INTEL_PATH_PREBUILTS_OUT))
endif
endif

tosimage: $(INSTALLED_TOS_IMAGE_TARGET)

ifeq ($(INTEL_PREBUILT), true)
$(INSTALLED_TOS_IMAGE_TARGET):
	$(hide) (cp $(INTEL_PATH_PREBUILTS)/tos.img $(INSTALLED_TOS_IMAGE_TARGET))
else
ifeq ($(wildcard $(TOS_PREBUILT)), )
ifeq (true,$(BOARD_AVB_ENABLE)) # BOARD_AVB_ENABLE == true
$(INSTALLED_TOS_IMAGE_TARGET): $(LK_ELF) $(MKBOOTIMG) $(AVBTOOL)
	@echo "mkbootimg to create boot image for TOS file: $@"
	$(hide) $(MKBOOTIMG) --kernel $(LK_ELF) --output $@
	@echo "$(AVBTOOL): add hashfooter to TOS file: $@"
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_TOSIMAGE_PARTITION_SIZE) \
		--partition_name tos
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) (cp $@ $(INTEL_PATH_PREBUILTS_OUT))
INSTALLED_VBMETAIMAGE_TARGET ?= $(PRODUCT_OUT)/vbmeta.img
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_TOS_IMAGE_TARGET)
$(INSTALLED_VBMETAIMAGE_TARGET): $(INSTALLED_TOS_IMAGE_TARGET)
else
$(INSTALLED_TOS_IMAGE_TARGET): $(LK_ELF) $(MKBOOTIMG) $(BOOT_SIGNER)
	@echo "mkbootimg to create boot image for TOS file: $@"
	$(hide) $(MKBOOTIMG) --kernel $(LK_ELF) --output $@
	$(if $(filter true,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_BOOT_SIGNER)),\
		@echo "$(BOOT_SIGNER): sign prebuilt TOS file: $@" &&\
		$(BOOT_SIGNER) /tos $@ $(SIGNING_KEY) $(SIGNING_CERT) $@)
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) (cp $@ $(INTEL_PATH_PREBUILTS_OUT))
endif
else
$(INSTALLED_TOS_IMAGE_TARGET):
	@echo "Use prebuilt tos image $(TOS_PREBUILT)"
	$(hide) (cp $(TOS_PREBUILT) $(INSTALLED_TOS_IMAGE_TARGET))
	$(hide) mkdir -p $(INTEL_PATH_PREBUILTS_OUT)
	$(hide) (cp $@ $(INTEL_PATH_PREBUILTS_OUT))

ifeq (true,$(BOARD_AVB_ENABLE)) # BOARD_AVB_ENABLE == true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_TOS_IMAGE_TARGET)
endif

endif
endif

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_TOS_IMAGE_TARGET)
INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_MULTIBOOT_IMAGE_TARGET)
