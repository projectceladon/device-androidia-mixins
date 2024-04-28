# Camera: Device-specific configuration files.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.external.xml:vendor/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/external_camera_config.xml:vendor/etc/external_camera_config.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/ivi_camera_config.xml:vendor/etc/ivi_camera_config.xml

# External camera service

PRODUCT_PACKAGES += android.iacamera.provider@2.4-ivi-service \
                    android.ia.hardware.camera.provider@2.4-ivi \
                    android.hardware.camera.provider@2.4-impl-ia

PRODUCT_PACKAGES += MultiCameraApp
PRODUCT_PACKAGES += Camera2
