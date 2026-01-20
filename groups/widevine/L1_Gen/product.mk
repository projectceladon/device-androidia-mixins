#enable Widevine drm
PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true


# There is an additional dependency on hdcpd that should be controlled
# through the content-protection mixin

PRODUCT_PACKAGES += android.hardware.drm-service.widevine
    #com.google.android.widevine
    #com.google.widevine.software.drm.xml \
    com.google.widevine.software.drm \
    libdrmwvmplugin \
    libdrmclearkeyplugin \
    libwvm \
    libdrmdecrypt \
    libWVStreamControlAPI_L1 \
    libwvdrm_L1

#PRODUCT_PACKAGES += android.hardware.drm@1.4-service.widevine \
                    android.hardware.drm@1.0-service \
                    android.hardware.drm@1.0-impl \
		    android.hardware.drm@1.4-service.clearkey \
		    libdrmclearkeyplugin \
                    libwvhidl 

# WV Modular
#PRODUCT_PACKAGES += libwvdrmengine

PRODUCT_PACKAGES_ENG += ExoPlayerDemo

PRODUCT_PACKAGES += liboemcrypto \
    sigma \

#CP prebuilt binaries
#PRODUCT_PACKAGES +=   \
    libcoreuclient    \
    libcoreuinterface \
    libcoreuservice   \
    coreu             \
    cplib             \
    libpavp           \
    libpcp            \
    libskuwa          \
    msync             \

BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 1
#TARGET_CFLAGS += -D__ANDROID_APEX__
#TARGET_CPPFLAGS += -D__ANDROID_APEX__
