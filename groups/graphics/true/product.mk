$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_COPY_FILES += \
    device/intel/cic/cic_cloud/SwiftShader.ini:root/SwiftShader.ini

PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libgrallocclient \
    libsync \
    audio.r_submix.default \
    audio.primary.$(TARGET_PRODUCT) \
    SoundRecorder \
    gralloc.intel_sw \
    libtextureservice

PRODUCT_PACKAGES += \
    android.hardware.drm@1.3-service.clearkey

# Device modules
PRODUCT_PACKAGES += \
	android.hardware.graphics.composer@2.3-service \
	android.hardware.graphics.allocator@2.0-service \
	android.hardware.graphics.allocator@2.0-impl \
	android.hardware.graphics.mapper@2.0-impl

PRODUCT_COPY_FILES += \
    device/intel/cic/cic_cloud/seccomp_policy/mediacodec.policy:system/vendor/etc/seccomp_policy/mediacodec.policy

PRODUCT_PROPERTY_OVERRIDES += ro.hardware.gralloc=intel_sw
PRODUCT_PROPERTY_OVERRIDES += ro.hardware.hwcomposer=intel_sw
PRODUCT_PROPERTY_OVERRIDES += ro.hardware.egl=swiftshader

PRODUCT_PACKAGES += hwcomposer.intel_sw

ifeq ($(TARGET_USE_GRALLOC_VHAL), true)
PRODUCT_PACKAGES += gralloc_imp.intel
else
PRODUCT_PACKAGES += gralloc.intel
endif

PRODUCT_PACKAGES += \
    vulkan.intel \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi \
    libdrm \
    libdrm_intel \
    i965_drv_video \
    libmfxhw32 \
    libmfxhw64 \
    libmfx_omx_core \
    libmfx_omx_components_hw \
    libstagefrighthw \
    libva-android \
    libva

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.vulkan=intel

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:system/vendor/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:system/vendor/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/vendor/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:system/vendor/etc/permissions/android.hardware.vulkan.version-1_1.xml

