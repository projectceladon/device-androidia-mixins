TARGET_USE_GRALLOC_VHAL := false
TARGET_USE_HWCOMPOSER_VHAL := true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:system/vendor/etc/permissions/android.hardware.vulkan.compute-0.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:system/vendor/etc/permissions/android.hardware.vulkan.level-1.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/vendor/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:system/vendor/etc/permissions/android.hardware.vulkan.version-1_1.xml

PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.3-service.clearkey \
    android.hardware.graphics.composer@2.3-service \
    android.hardware.graphics.mapper@4.0-impl.minigbm \
    android.hardware.graphics.allocator@4.0-service.minigbm

PRODUCT_PACKAGES += \
    vulkan.intel \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi \
    libdrm \
    libdrm_intel \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libgrallocclient \
    libsync \
    gralloc.intel_sw \
    libtextureservice \
    hwcomposer.intel_sw \
    egl.cfg \
    lib_renderControl_enc \
    libGLESv2_enc \
    libOpenglSystemCommon \
    libGLESv1_enc

PRODUCT_PACKAGES += \
    hwcomposer.goldfish \
    hwcomposer.ranchu \

ifeq ($(TARGET_USE_GRALLOC_VHAL), true)
PRODUCT_PACKAGES += gralloc_imp.intel
else
PRODUCT_PACKAGES += gralloc.intel
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=intel_sw \
    ro.hardware.hwcomposer=intel_sw \
    ro.hardware.egl=swiftshader \
    ro.hardware.vulkan=intel \
    debug.hwui.disable=1 \
    debug.egl.printFPS=60 \
    ro.opengles.version=196610 \
    linker.hugetlbfs.elfs=iris_dri.so:gallium_dri.so:libunity.so

