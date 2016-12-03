PRODUCT_PACKAGES += \
    audio.a2dp.default

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
        vendor/intel/fw/bluetooth/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq:system/etc/firmware/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq:intel \
        vendor/intel/fw/bluetooth/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq:system/etc/firmware/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq:intel \
