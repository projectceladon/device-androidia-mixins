ABOTA_BOOTARCH={{boot-arch}}

{{#slot-ab}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic
{{#ota_pre_o_version}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic/no_vendor_prefix
{{/ota_pre_o_version}}
{{^ota_pre_o_version}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic/vendor_prefix
{{/ota_pre_o_version}}

{{#post_fw_update}}
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    FILESYSTEM_TYPE_vendor={{system_fs}} \
    POSTINSTALL_OPTIONAL_vendor=true

{{#ota_pre_o_version}}
AB_OTA_POSTINSTALL_CONFIG += \
    POSTINSTALL_PATH_vendor=bin/update_ab
{{/ota_pre_o_version}}
{{^ota_pre_o_version}}
AB_OTA_POSTINSTALL_CONFIG += \
    POSTINSTALL_PATH_vendor=bin/update_ifwi_ab
{{/ota_pre_o_version}}

ifeq ($(ABOTA_BOOTARCH),efi)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/efi
endif

ifneq (, $(filter abl sbl, $(ABOTA_BOOTARCH)))
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/xbl
endif
{{/post_fw_update}}

{{#boot_fw_update}}
{{^post_fw_update}}
#---only xbl support
ifneq (, $(filter abl sbl, $(ABOTA_BOOTARCH)))
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/xbl
endif
{{/post_fw_update}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/fw_update
{{#ota_pre_o_version}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/fw_update/no_vendor_prefix
{{/ota_pre_o_version}}
{{^ota_pre_o_version}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/fw_update/vendor_prefix
{{/ota_pre_o_version}}
{{/boot_fw_update}}
{{/slot-ab}}
