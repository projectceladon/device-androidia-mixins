PRODUCT_PACKAGES += \
    hciattach \
	rfkillp \
    audio.a2dp.default

# Bluetooth FW
PRODUCT_PACKAGES += \
    bt_rtl8723b \
    bt_bcm43241 \
    bt_bcm43340 \
    bt_bcm4330 \
    bt_lnp_fw \

PRODUCT_COPY_FILES += frameworks/native/data/etc/android.hardware.bluetooth.xml:vendor/etc/permissions/android.hardware.bluetooth.xml \
		frameworks/native/data/etc/android.hardware.bluetooth_le.xml:vendor/etc/permissions/android.hardware.bluetooth_le.xml

# Bluetooth eng / userdebug
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    hciconfig \
    btmon \
    hcitool
endif
