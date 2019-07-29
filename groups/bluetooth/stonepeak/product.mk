PRODUCT_PACKAGES += \
    audio.a2dp.default

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

PRODUCT_COPY_FILES += \
        $(INTEL_PATH_VENDOR)/fw/bluetooth/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq:system/etc/firmware/intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq:intel \
