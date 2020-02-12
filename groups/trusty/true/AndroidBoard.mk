.PHONY: tosimage multiboot

EVMM_PKG := $(TOP)/$(PRODUCT_OUT)/obj/trusty/evmm_pkg.bin
EVMM_LK_PKG := $(TOP)/$(PRODUCT_OUT)/obj/trusty/evmm_lk_pkg.bin

LOCAL_MAKE := make

$(EVMM_PKG):
	@echo "making evmm.."
	$(hide) (cd $(TOPDIR)$(INTEL_PATH_VENDOR)/fw/evmm && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE))

$(EVMM_LK_PKG):
	@echo "making evmm(packing with lk.bin).."
	$(hide) (cd $(TOPDIR)$(INTEL_PATH_VENDOR)/fw/evmm && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE))

# include sub-makefile according to boot_arch
include $(TARGET_DEVICE_DIR)/{{_extra_dir}}/trusty_{{boot-arch}}.mk

LOAD_MODULES_H_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/load_trusty_modules.in
