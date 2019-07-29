PRODUCT_PACKAGES += \
{{#hsu}}
    bd_prov \
    libbt-vendor \
    rfkill_bt.sh \
    bt_vendor.default.conf \
{{/hsu}}
{{^hsu}}
    hciattach \
{{/hsu}}
    audio.a2dp.default \
{{#libbt_rtk}}
    rtl8723b_libbt_config \
    rtl8723b_libbt_fw \
{{/libbt_rtk}}
{{^libbt_rtk}}
    rtl8723b_config \
    rtl8723b_fw \
{{/libbt_rtk}}

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
		frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

{{^hsu}}
PRODUCT_PROPERTY_OVERRIDES += vendor.bluetooth.hwcfg=stop \
                bluetooth.rfkill=1

# Bluetooth eng / userdebug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
	hciconfig \
	btmon \
	hcitool
endif
{{/hsu}}
