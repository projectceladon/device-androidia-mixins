$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

ifeq ($(TARGET_USE_CAMERA_VHAL), true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/vendor/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/vendor/etc/permissions/android.hardware.camera.full.xml \
    device/intel/cic/common/media_codecs_performance.xml:system/etc/media_codecs_performance.xml

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
endif

# camera support
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-impl
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-external-service
PRODUCT_COPY_FILES += \
	device/intel/cic/common/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml


