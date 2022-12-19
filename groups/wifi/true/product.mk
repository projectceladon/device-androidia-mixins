$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

# WiFi
PRODUCT_PACKAGES += \
	wpa_supplicant \
	hostapd


