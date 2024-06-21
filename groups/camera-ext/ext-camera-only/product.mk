# Camera: Device-specific configuration files. Supports only External USB camera, no CSI support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.external.xml:vendor/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/external_camera_config.xml:vendor/etc/external_camera_config.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/remote_camera_config.xml:vendor/etc/remote_camera_config.xml


# External camera service
PRODUCT_PACKAGES += android.vendor.hardware.camera.provider-V1-external-service

#removing not required apps
# Only include test apps in eng or userdebug builds.
#PRODUCT_PACKAGES_DEBUG += TestingCamera

PRODUCT_PACKAGES += MultiCameraApp
