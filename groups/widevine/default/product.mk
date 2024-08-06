PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
  android.hardware.drm@1.4-service.widevine \
  libdrmclearkeyplugin 
  #libwvdrmengine \
  #libwvhidl \
  #android.hardware.drm@1.4-service.widevine

PRODUCT_PACKAGES_ENG += ExoPlayerDemo
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3

