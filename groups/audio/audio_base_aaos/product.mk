TARGET_BOARD_PLATFORM := celadon

# Tinyalsa
PRODUCT_PACKAGES_DEBUG += \
    tinymix \
    tinyplay \
    tinycap \
    tinypcminfo \
    tinyprobe

# Audio HALs
PRODUCT_PACKAGES += meta.package.audio

# Sound Trigger HAL
PRODUCT_PACKAGES += \
       sound_trigger.primary.$(TARGET_BOARD_PLATFORM)

# Audio Primary HAL
PRODUCT_PACKAGES += \
       audio.primary.$(TARGET_BOARD_PLATFORM)

# Extended Audio HALs
PRODUCT_PACKAGES += \
    audio.r_submix.default \
    audio.usb.default \
    audio.usb.$(TARGET_BOARD_PLATFORM) \
    audio.hdmi.$(TARGET_BOARD_PLATFORM) \
    audio_policy.default.so \
    audio_configuration_files

# Audio HAL
PRODUCT_PACKAGES += \
    com.android.hardware.audio.intel \
    android.hardware.automotive.audiocontrol-service.example

# rro overlay for audioUseDynamicRouting
PRODUCT_PACKAGES += \
    CarServiceMultiDisplayOverlayIntel

#Audio policy engine configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_criteria.conf:vendor/etc/audio_policy_criteria.conf

# Vendor audio configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration.xml:vendor/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/car_audio_configuration.xml:vendor/etc/car_audio_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration_attached_devices.xml:vendor/etc/audio_policy_configuration_attached_devices.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration_devices.xml:vendor/etc/audio_policy_configuration_devices.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration_mixports.xml:vendor/etc/audio_policy_configuration_mixports.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_configuration_routes.xml:vendor/etc/audio_policy_configuration_routes.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_hal_configuration.xml:vendor/etc/audio_hal_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_hal_configuration_intel_poc.xml:vendor/etc/audio_hal_configuration_intel_poc.xml \
    $(LOCAL_PATH)/audio/default/policy/a2dp_audio_policy_configuration.xml:vendor/etc/a2dp_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/r_submix_audio_policy_configuration.xml:vendor/etc/r_submix_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/usb_audio_policy_configuration.xml:vendor/etc/usb_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/hdmi_audio_policy_configuration.xml:vendor/etc/hdmi_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/audio_policy_volumes.xml:vendor/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default/policy/default_volume_tables.xml:vendor/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/default/effect/audio_effects.xml:vendor/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/default/effect/audio_effects_config.xml:vendor/etc/audio_effects_config.xml

ifeq ($(BASE_YOCTO_KERNEL), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/mixer_paths_ehl.xml:vendor/etc/mixer_paths_0.xml \
    $(LOCAL_PATH)/audio/default/mixer_paths_usb.xml:vendor/etc/mixer_paths_usb.xml

PRODUCT_PROPERTY_OVERRIDES += ro.vendor.hdmi.audio=ehl
else
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/mixer_paths_0.xml:vendor/etc/mixer_paths_0.xml \
    $(LOCAL_PATH)/audio/default/mixer_paths_usb.xml:vendor/etc/mixer_paths_usb.xml
endif

#fallback
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/default/policy/fallback/audio_policy_configuration_generic.xml:system/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/fallback/car_audio_configuration.xml:system/etc/car_audio_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/fallback/primary_audio_policy_configuration.xml:system/etc/primary_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/fallback/r_submix_audio_policy_configuration.xml:system/etc/r_submix_audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/default/policy/fallback/audio_policy_volumes.xml:system/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/default/policy/fallback/default_volume_tables.xml:system/etc/default_volume_tables.xml

ifeq ($(VM3), true)
PRODUCT_PRODUCT_PROPERTIES += ro.vendor.audio.vm3=1
endif

PRODUCT_PROPERTY_OVERRIDES += audio.safemedia.bypass=true

#PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/audio/overlay-car-legacy
