PRODUCT_PACKAGES += \
    audio.a2dp.default \
    ath3k-1.fw

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
    vendor/linux/firmware/intel/ibt-18-16-1.ddc:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-18-16-1.ddc \
    vendor/linux/firmware/intel/ibt-18-16-1.sfi:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-18-16-1.sfi \
    vendor/linux/firmware/intel/ibt-18-2.ddc:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-18-2.ddc \
    vendor/linux/firmware/intel/ibt-18-2.sfi:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-18-2.sfi \
    vendor/linux/firmware/intel/ibt-12-16.ddc:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-12-16.ddc \
    vendor/linux/firmware/intel/ibt-12-16.sfi:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-12-16.sfi \
    vendor/linux/firmware/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq

PRODUCT_PROPERTY_OVERRIDES += bluetooth.rfkill=1

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service.vbt \
    libbt-vendor \
{{#firmware}}
    {{firmware}}
{{/firmware}}

{{#ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-car
{{/ivi}}

{{^ivi}}
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-tablet
{{/ivi}}

