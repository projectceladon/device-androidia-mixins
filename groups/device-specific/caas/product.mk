TARGET_BOARD_PLATFORM := broxton

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
                    android.hardware.graphics.composer@2.1-service

PRODUCT_COPY_FILES += $(LOCAL_PATH)/manifest.xml:vendor/manifest.xml
PRODUCT_COPY_FILES += $(LOCAL_PATH)/file_share.sh:$(TARGET_COPY_OUT_VENDOR)/bin/file_share.sh

# To install thirdparty apk
PRODUCT_PACKAGES += Airwatch \
    Ingenico \
    Teamviewer

PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libchilkat.so:system/app/Airwatch/lib/x86/libchilkat.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libcoredevice.so:system/app/Airwatch/lib/x86/libcoredevice.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libcrypto.1.0.2.so:system/app/Airwatch/lib/x86/libcrypto.1.0.2.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libfips_main.so:system/app/Airwatch/lib/x86/libfips_main.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libssl.1.0.2.so:system/app/Airwatch/lib/x86/libssl.1.0.2.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libencjni.so:system/app/Airwatch/lib/x86/libencjni.so
PRODUCT_COPY_FILES += $(INTEL_PATH_COMMON)/lib/x86/libsqlcipher.so:system/app/Airwatch/lib/x86/libsqlcipher.so

