TOS_IMAGE_TARGET := $(TRUSTY_BUILDROOT)/evmm_lk_pkg.bin

INTERNAL_PLATFORM := ikgt
LOCAL_MAKE := make

# Build the evmm_pkg.bin and lk.bin
.PHONY: $(TOS_IMAGE_TARGET)
$(TOS_IMAGE_TARGET):
	@echo "making lk.bin.."
	$(hide) (cd $(TOPDIR)trusty && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE) {{{lk_project}}})
	@echo "making tos image.."
	$(hide) (cd $(TOPDIR)vendor/intel/fw/evmm/$(INTERNAL_PLATFORM) && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE))

#tos partition is assigned for trusty
INSTALLED_TOS_IMAGE_TARGET := $(PRODUCT_OUT)/tos.img
TOS_SIGNING_KEY := $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_VERITY_SIGNING_KEY).pk8
TOS_SIGNING_CERT := $(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_VERITY_SIGNING_KEY).x509.pem

.PHONY: tosimage
tosimage: $(INSTALLED_TOS_IMAGE_TARGET)

ifeq (true,$(BOARD_AVB_ENABLE)) # BOARD_AVB_ENABLE == true
$(INSTALLED_TOS_IMAGE_TARGET): $(TOS_IMAGE_TARGET) $(MKBOOTIMG) $(AVBTOOL)
	@echo "mkbootimg to create boot image for TOS file: $@"
	$(hide) $(MKBOOTIMG) --kernel $(TOS_IMAGE_TARGET) --output $@
	$(hide) $(AVBTOOL) add_hash_footer \
		--image $@ \
		--partition_size $(BOARD_TOSIMAGE_PARTITION_SIZE) \
		--partition_name tos $(INTERNAL_AVB_SIGNING_ARGS)
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --include_descriptors_from_image $(INSTALLED_TOS_IMAGE_TARGET)
$(PRODUCT_OUT)/vbmeta.img: $(INSTALLED_TOS_IMAGE_TARGET)
else
$(INSTALLED_TOS_IMAGE_TARGET): $(TOS_IMAGE_TARGET) $(MKBOOTIMG) $(BOOT_SIGNER)
	@echo "mkbootimg to create boot image for TOS file: $@"
	$(hide) $(MKBOOTIMG) --kernel $(TOS_IMAGE_TARGET) --output $@
	$(if $(filter true,$(PRODUCTS.$(INTERNAL_PRODUCT).PRODUCT_SUPPORTS_BOOT_SIGNER)),\
		@echo "sign prebuilt TOS file: $@" &&\
		$(BOOT_SIGNER) /tos $@ $(TOS_SIGNING_KEY) $(TOS_SIGNING_CERT) $@)
endif

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_TOS_IMAGE_TARGET)

{{#slot-ab}}
make_dir_ab_tos:
	@mkdir -p $(PRODUCT_OUT)/root/tos

$(PRODUCT_OUT)/ramdisk.img: make_dir_ab_tos
{{/slot-ab}}
