# Camera: Device-specific configuration files.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:vendor/etc/permissions/android.hardware.camera.xml
    $(LOCAL_PATH)/{{_extra_dir}}/media_profiles_V1_0.xml:vendor/etc/media_profiles_V1_0.xml

# External camera service

PRODUCT_PACKAGES += android.iacamera.provider@2.4-ivi-service \
                    android.ia.hardware.camera.provider@2.4-ivi \
                    android.hardware.camera.provider@2.4-impl-ia

PRODUCT_PACKAGES += android.ia.hardware.camera.provider-ivi \
					android.iacamera.provider-ivi-service

PRODUCT_PACKAGES += Camera2
PRODUCT_PACKAGES += MultiCameraApp

PRODUCT_PACKAGES += yavta
PRODUCT_PACKAGES += media-ctl

