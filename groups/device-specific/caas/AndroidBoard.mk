KERNEL_APL_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/apl_nuc_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_APL_DIFFCONFIG)
KERNEL_caas_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/caas_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_caas_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

BOARD_GPT_IMG = $(PRODUCT_OUT)/gpt.img
BOARD_FLASHFILES += $(BOARD_GPT_IMG):gpt.img

GPT_INI2IMG := ./$(INTEL_PATH_BUILD)/create_gpt_image.py

intermediate_img := $(call intermediates-dir-for,PACKAGING,flashfiles)/gpt.img

$(BOARD_GPT_IMG): $(BOARD_GPT_INI)
	$(hide) mkdir -p $(dir $(intermediate_img))
	$(hide) $(GPT_INI2IMG) --create --block $(BOARD_FLASH_BLOCK_SIZE) --table $< --size $(BOARD_MMC_SIZE) $(intermediate_img)
	$(hide) dd if=$(intermediate_img) of=$@ bs=$(BOARD_FLASH_BLOCK_SIZE) count=34
	$(hide) echo GEN $(notdir $@)
LOCAL_CLANG_PATH = $(CLANG_PREBUILTS_PATH)/host/$(HOST_OS)-x86/$(KERNEL_CLANG_VERSION)/bin

LOCAL_MAKE:= \
        PATH="$(LOCAL_CLANG_PATH):$(PWD)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/x86_64-linux/bin:$$PATH" \
	$(PWD)/prebuilts/build-tools/linux-x86/bin/make

.PHONY: vinput-manager
vinput-manager:
	cd device/intel/civ/host/virtual-input-manager && $(LOCAL_MAKE)
	cp device/intel/civ/host/virtual-input-manager/vinput-manager $(PRODUCT_OUT)/scripts/
	cp device/intel/civ/host/virtual-input-manager/sendkey $(PRODUCT_OUT)/scripts/

.PHONY: em-host-utilities
em-host-utilities:
	mkdir -p $(PRODUCT_OUT)/scripts/
	cd device/intel/civ/host/backend/battery/vm_battery_utility && $(LOCAL_MAKE)
	cp device/intel/civ/host/backend/battery/vm_battery_utility/batsys $(PRODUCT_OUT)/scripts/
	cd device/intel/civ/host/backend/thermal/vm_thermal_utility && $(LOCAL_MAKE)
	cp device/intel/civ/host/backend/thermal/vm_thermal_utility/thermsys $(PRODUCT_OUT)/scripts/

.PHONY: host-pkg
host-pkg: em-host-utilities vinput-manager
