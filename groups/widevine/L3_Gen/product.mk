PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
PRODUCT_PACKAGES += \
  com.google.android.widevine
  #android.hardware.drm-service.widevine
  #libdrmclearkeyplugin 
  #libwvdrmengine \
  #libwvhidl \
  #android.hardware.drm@1.4-service.widevine

PRODUCT_PACKAGES_ENG += ExoPlayerDemo
BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
TARGET_CFLAGS += -D__ANDROID_APEX__
TARGET_CPPFLAGS += -D__ANDROID_APEX__
