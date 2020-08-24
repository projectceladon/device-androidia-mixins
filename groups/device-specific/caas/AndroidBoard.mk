KERNEL_APL_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/apl_nuc_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_APL_DIFFCONFIG)
KERNEL_caas_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/caas_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_caas_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

.PHONY: vinput-manager
vinput-manager:
	cd device/intel/civ/host/virtual-input-manager && make
	cp device/intel/civ/host/virtual-input-manager/vinput-manager $(PRODUCT_OUT)/scripts/
	cp device/intel/civ/host/virtual-input-manager/sendkey $(PRODUCT_OUT)/scripts/

.PHONY: em-host-utilities
em-host-utilities:
	mkdir -p $(PRODUCT_OUT)/scripts/
	cd device/intel/civ/host/backend/battery/vm_battery_utility && make
	cp device/intel/civ/host/backend/battery/vm_battery_utility/batsys $(PRODUCT_OUT)/scripts/
	cd device/intel/civ/host/backend/thermal/vm_thermal_utility && make
	cp device/intel/civ/host/backend/thermal/vm_thermal_utility/thermsys $(PRODUCT_OUT)/scripts/

.PHONY: host-pkg
host-pkg: em-host-utilities vinput-manager
