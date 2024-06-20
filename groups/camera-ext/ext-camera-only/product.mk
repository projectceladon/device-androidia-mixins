# Camera: Device-specific configuration files. Supports only External USB camera, no CSI support
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.external.xml:vendor/etc/permissions/android.hardware.camera.external.xml \
    $(LOCAL_PATH)/{{_extra_dir}}/external_camera_config.xml:vendor/etc/external_camera_config.xml

# External camera service
PRODUCT_PACKAGES += android.hardware.camera.provider@2.4-external-service \
                    android.hardware.camera.provider@2.4-service \
                    android.hardware.camera.provider@2.4-impl
#VHAL camera
PRODUCT_PACKAGES += camera.$(TARGET_BOARD_PLATFORM) \
                    camera.$(TARGET_BOARD_PLATFORM).jpeg

PRODUCT_PROPERTY_OVERRIDES += ro.vendor.remote.sf.fake_camera ="both" \
                              ro.vendor.camera.in_frame_format.h264=false \
                              ro.vendor.camera.in_frame_format.i420=true \
                              ro.vendor.camera.decode.vaapi=false \
                              ro.vendor.remote.sf.back_camera_hal= \
                              ro.vendor.remote.sf.front_camera_hal= \
                              ro.vendor.camera.transference="VSOCK" \
                              vendor.camera.external="VHAL"
#removing not required apps
# Only include test apps in eng or userdebug builds.
#PRODUCT_PACKAGES_DEBUG += TestingCamera

#PRODUCT_PACKAGES += MultiCameraApp
