KERNEL_APL_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/apl_nuc_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_APL_DIFFCONFIG)
KERNEL_caas_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/caas_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_caas_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

.PHONY: em-host-utilities

em-host-utilities:
	cd device/intel/civ/host/backend/battery/vm_battery_utility && make
	cp device/intel/civ/host/backend/battery/vm_battery_utility/batsys $(PRODUCT_OUT)/scripts/
	cd device/intel/civ/host/backend/thermal/vm_thermal_utility && make
	cp device/intel/civ/host/backend/thermal/vm_thermal_utility/thermsys $(PRODUCT_OUT)/scripts/
