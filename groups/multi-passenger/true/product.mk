# multi-passenger support
PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-multi_passenger
# Vendor audio configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/overlay-multi_passenger/audio/audio_policy_configuration.xml:vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/overlay-multi_passenger/audio/car_audio_configuration.xml:vendor/etc/car_audio_configuration.xml
