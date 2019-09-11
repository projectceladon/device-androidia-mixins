FIRMWARES_DIR ?= vendor/linux/firmware
{{#all_firmwares}}
INCLUDE_ALL_FIRMWARE := true
{{/all_firmwares}}

$(call inherit-product,device/intel/common/firmware.mk)
