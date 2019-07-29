PRODUCT_PACKAGES += \
    bt_vendor.conf \
    audio.a2dp.default \
    a00.pbn \
    a10.pbn \
    a11.pbn \
    bddata \
    bt_nvm_init.sh \

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml \

