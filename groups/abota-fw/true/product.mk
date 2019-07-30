ABOTA_BOOTARCH={{boot-arch}}

{{#slot-ab}}
{{^ota_pre_o_version}}
{{#post_fw_update}}
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/update_ifwi_ab.sh:vendor/bin/update_ifwi_ab
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/update_ifwi_ab.sh:recovery/root/vendor/bin/update_ifwi_ab

ifeq ($(ABOTA_BOOTARCH),abl)
PRODUCT_PACKAGES += \
    abl-user-cmd_vendor \
    abl-user-cmd_static
endif

ifeq ($(ABOTA_BOOTARCH),sbl)
PRODUCT_PACKAGES += \
    sbl-user-cmd_vendor \
    sbl-user-cmd_static
endif
{{/post_fw_update}}

{{#boot_fw_update}}
#only support abl
ifeq ($(ABOTA_BOOTARCH),abl)
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/update_ifwi_boot.sh:vendor/bin/fw_update.sh
endif

{{^post_fw_update}}
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/update_ifwi_ab.sh:vendor/bin/update_ifwi_ab
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/update_ifwi_ab.sh:recovery/root/vendor/bin/update_ifwi_ab

ifeq ($(ABOTA_BOOTARCH),abl)
PRODUCT_PACKAGES += \
    abl-user-cmd_vendor \
    abl-user-cmd_static
endif
{{/post_fw_update}}
{{/boot_fw_update}}
{{/ota_pre_o_version}}
{{#ota_pre_o_version}}
ifeq ($(ABOTA_BOOTARCH),abl)
PRODUCT_PACKAGES += \
    abl-user-cmd_vendor \
    abl-user-cmd_static

PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/upgrade_o/updater_ab.sh:vendor/bin/updater_ifwi_ab
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/upgrade_o/fw_update.sh:vendor/bin/fw_update.sh
endif
{{/ota_pre_o_version}}
{{/slot-ab}}
