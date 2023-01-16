TARGET_USE_CAMERA_VHAL := true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/vendor/etc/permissions/android.hardware.camera.full.xml \

PRODUCT_PACKAGES += \
    camera.$(TARGET_PRODUCT) \
    camera.$(TARGET_PRODUCT).jpeg \
    Camera2 \
    camera.device@1.0-impl \
    android.hardware.camera.provider@2.4-service_64 \
    android.hardware.camera.provider@2.4-impl

PRODUCT_PROPERTY_OVERRIDES += \
    remote.sf.fake_camera=both \
    persist.remote.camera.orientation=landscape

# camera support
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-external-service
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml

