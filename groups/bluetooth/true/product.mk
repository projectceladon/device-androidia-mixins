$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth@1.0-impl

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_PACKAGES += DummyHome

PRODUCT_PROPERTY_OVERRIDES += \
    enable.restrictions=true \
    enable.sec_key_att_app_id_provider=true \
    enable.power=true \
    enable.launcher=true \
    enable.settings=true \
    enable.clipboard=true \
    enable.network_score=true \
    enable.telephony.registry=true \
    enable.netstats=true \
    enable.batterystats=true

