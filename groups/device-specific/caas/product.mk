TARGET_BOARD_PLATFORM := celadon

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.rc:root/init.recovery.$(TARGET_PRODUCT).rc \
{{#treble}}
    $(LOCAL_PATH)/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
{{/treble}}
{{^treble}}
    $(LOCAL_PATH)/init.rc:root/init.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/ueventd.rc:root/ueventd.$(TARGET_PRODUCT).rc \
{{/treble}}

PRODUCT_PACKAGES += android.hardware.keymaster@3.0-impl \
                    android.hardware.keymaster@3.0-service \
                    android.hardware.usb@1.0-impl \
                    android.hardware.usb@1.0-service \
                    android.hardware.dumpstate@1.0-impl \
                    android.hardware.dumpstate@1.0-service \
                    camera.device@1.0-impl \
                    android.hardware.camera.provider@2.4-impl \
                    android.hardware.camera.provider@2.4-service \
                    android.hardware.graphics.mapper@2.0-impl \
                    android.hardware.graphics.allocator@2.0-impl \
                    android.hardware.graphics.allocator@2.0-service \
                    android.hardware.renderscript@1.0-impl \
                    android.hardware.graphics.composer@2.1-impl \
                    android.hardware.graphics.composer@2.1-service \
                    batsys \
                    thermsys \
                    vinput-manager \
                    sendkey


PRODUCT_COPY_FILES += $(LOCAL_PATH)/manifest.xml:vendor/manifest.xml
PRODUCT_COPY_FILES += $(LOCAL_PATH)/file_share.sh:$(TARGET_COPY_OUT_VENDOR)/bin/file_share.sh
PRODUCT_COPY_FILES += vendor/intel/utils/LICENSE:$(PRODUCT_OUT)/LICENSE
PRODUCT_COPY_FILES += $(LOCAL_PATH)/auto_switch_pt_usb_vms.sh:$(PRODUCT_OUT)/scripts/auto_switch_pt_usb_vms.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/findall.py:$(PRODUCT_OUT)/scripts/findall.py
PRODUCT_COPY_FILES += $(LOCAL_PATH)/sof_audio/configure_sof.sh:$(PRODUCT_OUT)/scripts/sof_audio/configure_sof.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/setup_audio_host.sh:$(PRODUCT_OUT)/scripts/setup_audio_host.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/sof_audio/blacklist-dsp.conf:$(PRODUCT_OUT)/scripts/sof_audio/blacklist-dsp.conf
PRODUCT_COPY_FILES += $(LOCAL_PATH)/guest_pm_control:$(PRODUCT_OUT)/scripts/guest_pm_control
PRODUCT_COPY_FILES += $(LOCAL_PATH)/intel-thermal-conf.xml:$(PRODUCT_OUT)/scripts/intel-thermal-conf.xml
PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermald.service:$(PRODUCT_OUT)/scripts/thermald.service
PRODUCT_COPY_FILES += device/intel/civ/host/vm-manager/scripts/start_civ.sh:$(PRODUCT_OUT)/scripts/start_civ.sh
PRODUCT_COPY_FILES += device/intel/civ/host/vm-manager/scripts/setup_host.sh:$(PRODUCT_OUT)/scripts/setup_host.sh
PRODUCT_COPY_FILES += device/intel/civ/host/vm-manager/scripts/guest_time_keeping.sh:$(PRODUCT_OUT)/scripts/guest_time_keeping.sh
PRODUCT_COPY_FILES += device/intel/civ/host/vm-manager/scripts/start_flash_usb.sh:$(PRODUCT_OUT)/scripts/start_flash_usb.sh
PRODUCT_COPY_FILES += vendor/intel/fw/trusty-release-binaries/rpmb_dev:$(PRODUCT_OUT)/scripts/rpmb_dev
PRODUCT_COPY_FILES += device/intel/civ/host/backend/battery/bin/batsys:$(PRODUCT_OUT)/scripts/batsys
PRODUCT_COPY_FILES += device/intel/civ/host/backend/thermal/bin/thermsys:$(PRODUCT_OUT)/scripts/thermsys
PRODUCT_COPY_FILES += $(LOCAL_PATH)/wakeup.py:$(PRODUCT_OUT)/scripts/wakeup.py
PRODUCT_COPY_FILES += device/intel/civ/host/virtual-input-manager/bin/sendkey:$(PRODUCT_OUT)/scripts/sendkey
PRODUCT_COPY_FILES += device/intel/civ/host/virtual-input-manager/bin/vinput-manager:$(PRODUCT_OUT)/scripts/vinput-manager

#Adoptable Storage encryption support for CTS
PRODUCT_PROPERTY_OVERRIDES += \
        ro.crypto.volume.filenames_mode=aes-256-cts

