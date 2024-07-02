# enables the rro package for passenger(secondary) user.
ENABLE_PASSENGER_SYSTEMUI_RRO := true

PRODUCT_PACKAGES += CarServiceMultiDisplayOverlay \
                    MultiDisplaySecondaryHomeTestLauncher

PRODUCT_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay-multi_passenger

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.managed_users.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.managed_users.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/car_audio_configuration.xml:vendor/etc/car_audio_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_attached_devices.xml:vendor/etc/audio_policy_configuration_attached_devices.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_devices.xml:vendor/etc/audio_policy_configuration_devices.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_mixports.xml:vendor/etc/audio_policy_configuration_mixports.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration_routes.xml:vendor/etc/audio_policy_configuration_routes.xml \
    $(LOCAL_PATH)/audio/audio_hal_configuration.xml:vendor/etc/audio_hal_configuration.xml \
    $(LOCAL_PATH)/audio/audio_hal_configuration_intel_poc.xml:vendor/etc/audio_hal_configuration_intel_poc.xml 


PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml

