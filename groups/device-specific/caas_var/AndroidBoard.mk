KERNEL_APL_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/apl_nuc_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_APL_DIFFCONFIG)
KERNEL_caas_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/caas_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_caas_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

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
