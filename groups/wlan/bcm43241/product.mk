PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/hostapd.conf:vendor/etc/wifi/hostapd.conf \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += wpa_supplicant \
    hostapd \
    wlan_prov \
    sec_tool \
    brcmfmac43241b4-sdio.bin \
    brcmfmac43241b4-sdio_apsta.bin \
    brcmfmac43241b4-sdio.txt \
    brcmfmac43241b4-oob-sdio.txt

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += wifi.interface=wlan0
