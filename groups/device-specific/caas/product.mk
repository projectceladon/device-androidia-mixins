TARGET_BOARD_PLATFORM := celadon

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_REQUIRES_INSECURE_EXECMEM_FOR_SWIFTSHADER := true
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.recovery.rc:root/init.recovery.$(TARGET_PRODUCT).rc \
{{#treble}}
    $(LOCAL_PATH)/init.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/ueventd.rc:$(TARGET_COPY_OUT_VENDOR)/etc/ueventd.rc \
{{/treble}}
{{^treble}}
    $(LOCAL_PATH)/init.rc:root/init.$(TARGET_PRODUCT).rc \
    $(LOCAL_PATH)/ueventd.rc:root/ueventd.$(TARGET_PRODUCT).rc \
{{/treble}}

PRODUCT_PACKAGES += vndservicemanager

PRODUCT_PACKAGES += ClipboardAgent

# PRODUCT_PACKAGES += androidx.window.extensions \
		    androidx.window.sidecar

PRODUCT_PACKAGES +=  \
                    android.hardware.usb-service.example \
                    camera.vendor.device@1.0-impl \
                    android.hardware.camera.provider@2.4-impl-intel \
                    android.hardware.graphics.mapper@4.0-impl.minigbm_intel \
                    android.hardware.graphics.allocator-service.minigbm \
                    android.hardware.renderscript@1.0-impl \
                    android.hardware.identity \
                    android.hardware.identity-service.example \
		    android.hardware.graphics.composer3-service.intel \
                    android.hardware.media.omx@1.0-service


PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce
PRODUCT_PROPERTY_OVERRIDES += dalvik.vm.useautofastjni=true
PRODUCT_PRODUCT_PROPERTIES += persist.adb.tcp.port=5555
PRODUCT_PRODUCT_PROPERTIES += persist.sys.fuse.bpf.enable=true

PRODUCT_PROPERTY_OVERRIDES += \
    ro.crypto.volume.metadata.method=dm-default-key \
    ro.crypto.dm_default_key.options_format.version=2 \
    ro.crypto.volume.options=::v2

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.device_admin.xml:vendor/etc/permissions/android.software.device_admin.xml \
    frameworks/native/data/etc/android.software.managed_users.xml:vendor/etc/permissions/android.software.managed_users.xml \
    frameworks/native/data/etc/android.software.secure_lock_screen.xml:vendor/etc/permissions/android.software.secure_lock_screen.xml

PRODUCT_COPY_FILES += $(LOCAL_PATH)/file_share.sh:$(TARGET_COPY_OUT_VENDOR)/bin/file_share.sh
PRODUCT_COPY_FILES += vendor/intel/utils/bsp_diff/file_for_flashfile:$(PRODUCT_OUT)/LICENSE
PRODUCT_COPY_FILES += $(LOCAL_PATH)/auto_switch_pt_usb_vms.sh:$(PRODUCT_OUT)/scripts/auto_switch_pt_usb_vms.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/findall.py:$(PRODUCT_OUT)/scripts/findall.py
PRODUCT_COPY_FILES += $(LOCAL_PATH)/sof_audio/configure_sof.sh:$(PRODUCT_OUT)/scripts/sof_audio/configure_sof.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/cam_sharing/0001-Netlink-sync.patch:$(PRODUCT_OUT)/scripts/cam_sharing/0001-Netlink-sync.patch
PRODUCT_COPY_FILES += $(LOCAL_PATH)/cam_sharing/IntelCameraService:$(PRODUCT_OUT)/scripts/cam_sharing/IntelCameraService
PRODUCT_COPY_FILES += $(LOCAL_PATH)/cam_sharing/virtualcamera.service:$(PRODUCT_OUT)/scripts/cam_sharing/virtualcamera.service
PRODUCT_COPY_FILES += $(LOCAL_PATH)/setup_audio_host.sh:$(PRODUCT_OUT)/scripts/setup_audio_host.sh
PRODUCT_COPY_FILES += $(LOCAL_PATH)/guest_pm_control:$(PRODUCT_OUT)/scripts/guest_pm_control
PRODUCT_COPY_FILES += $(LOCAL_PATH)/intel-thermal-conf.xml:$(PRODUCT_OUT)/scripts/intel-thermal-conf.xml
PRODUCT_COPY_FILES += $(LOCAL_PATH)/thermald.service:$(PRODUCT_OUT)/scripts/thermald.service
PRODUCT_COPY_FILES += device/intel/common/host_scripts/setup_host.sh:$(PRODUCT_OUT)/scripts/setup_host.sh
PRODUCT_COPY_FILES += device/intel/common/host_scripts/ai_raw_tensor.sh:$(PRODUCT_OUT)/scripts/ai_raw_tensor.sh
PRODUCT_COPY_FILES += device/intel/common/host_scripts/setup_ai_dispatcher.sh:$(PRODUCT_OUT)/scripts/setup_ai_dispatcher.sh
PRODUCT_COPY_FILES += device/intel/common/host_scripts/setup_cam_sharing.sh:$(PRODUCT_OUT)/scripts/setup_cam_sharing.sh
PRODUCT_COPY_FILES += device/intel/common/host_scripts/guest_time_keeping.sh:$(PRODUCT_OUT)/scripts/guest_time_keeping.sh
PRODUCT_COPY_FILES += device/intel/common/host_scripts/start_flash_usb.sh:$(PRODUCT_OUT)/scripts/start_flash_usb.sh
PRODUCT_COPY_FILES += vendor/intel/fw/trusty-release-binaries/rpmb_dev:$(PRODUCT_OUT)/scripts/rpmb_dev
PRODUCT_COPY_FILES += $(LOCAL_PATH)/wakeup.py:$(PRODUCT_OUT)/scripts/wakeup.py
PRODUCT_COPY_FILES += device/intel/civ/host/vm-manager-binaries/vm-manager.deb:$(PRODUCT_OUT)/scripts/vm-manager.deb
