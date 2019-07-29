PRODUCT_COPY_FILES += \
    $(INTEL_PATH_COMMON)/wlan/wpa_supplicant-common.conf:vendor/etc/wifi/wpa_supplicant.conf \
    $(INTEL_PATH_COMMON)/wlan/bcm4356/wpa_supplicant_overlay.conf:vendor/etc/wifi/wpa_supplicant_overlay.conf \
    $(INTEL_PATH_COMMON)/wlan/hostapd.conf:vendor/etc/wifi/hostapd.conf \
    frameworks/native/data/etc/android.hardware.wifi.xml:vendor/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:vendor/etc/permissions/android.hardware.wifi.direct.xml

PRODUCT_PACKAGES += wpa_supplicant \
    hostapd \
    wlan_prov \
    sec_tool \
    fw_bcmdhd_4356a2_pcie.bin \
    fw_bcmdhd_4356a2_pcie_apsta.bin \
    nvram_pcie_4356_a2.cal


PRODUCT_PACKAGES_DEBUG += dhdutil_1.201.90

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += wifi.interface=wlan0
