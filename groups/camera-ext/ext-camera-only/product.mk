# Camera: Device-specific configuration files. Supports only External USB camera, no CSI support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.external.xml:vendor/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/external_camera_config.xml:vendor/etc/external_camera_config.xml
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles_V1_0.xml:vendor/etc/media_profiles_V1_0.xml

# External camera service
PRODUCT_PACKAGES += android.hardware.camera.provider-V1-external-service

# Only include test apps in eng or userdebug builds.
#PRODUCT_PACKAGES_DEBUG += TestingCamera

PRODUCT_PACKAGES += MultiCameraApp
