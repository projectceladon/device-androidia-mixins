.PHONY: tosimage multiboot

LK_ELF := $(TOP)/$(PRODUCT_OUT)/obj/trusty/build-{{{lk_project}}}/lk.elf
EVMM_PKG := $(TOP)/$(PRODUCT_OUT)/obj/trusty/evmm_pkg.bin
EVMM_LK_PKG := $(TOP)/$(PRODUCT_OUT)/obj/trusty/evmm_lk_pkg.bin

LOCAL_MAKE := make

$(LK_ELF):
	@echo "making lk.elf.."
	$(hide) (cd $(TOPDIR)trusty && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE) {{{lk_project}}})

$(EVMM_PKG): | yoctotoolchain
	@echo "making evmm.."
	$(hide) (cd $(TOPDIR)$(INTEL_PATH_VENDOR)/fw/evmm && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE))

$(EVMM_LK_PKG): $(LK_ELF) | yoctotoolchain
	@echo "making evmm(packing with lk.elf).."
	$(hide) (cd $(TOPDIR)$(INTEL_PATH_VENDOR)/fw/evmm && $(TRUSTY_ENV_VAR) $(LOCAL_MAKE))

# include sub-makefile according to boot_arch
include $(TARGET_DEVICE_DIR)/{{_extra_dir}}/trusty_{{boot-arch}}.mk

LOAD_MODULES_H_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/load_trusty_modules.in
