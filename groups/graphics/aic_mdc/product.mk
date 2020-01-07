PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/vendor/etc/permissions/android.hardware.opengles.aep.xml \

PRODUCT_PACKAGES += \
    egl.cfg \
    lib_renderControl_enc \
    libGLESv2_enc \
    libOpenglSystemCommon \
    libGLESv1_enc \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl \
    hwcomposer.goldfish \
    hwcomposer.ranchu \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0-impl \

ifeq ($(TARGET_USE_GRALLOC_VHAL), true)
PRODUCT_COPY_FILES += \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/bin/gralloc1_test:system/vendor/bin/gralloc1_test \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/bin/test_lxc_server:system/vendor/bin/test_lxc_server \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/bin/test_lxc_client:system/vendor/bin/test_lxc_client \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/lib/hw/gralloc.intel.so:system/vendor/lib/hw/gralloc.intel.so \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/lib64/hw/gralloc.intel.so:system/vendor/lib64/hw/gralloc.intel.so \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/lib/liblxc_util.so:system/vendor/lib/liblxc_util.so \
    $(INTEL_PATH_VENDOR_CIC_GRAPHIC)/edge/system/vendor/lib64/liblxc_util.so:system/vendor/lib64/liblxc_util.so
endif

PRODUCT_PACKAGES += \
    libGLES_mesa \
    libdrm \
    libdrm_intel \
    libsync \
    Browser2 \
    RemoteIME \
    ServiceAgent \
    auto_start_apk.sh

ifeq ($(TARGET_USE_GRALLOC_VHAL), true)
PRODUCT_PACKAGES += gralloc_imp.intel
else
PRODUCT_PACKAGES += gralloc.intel
endif

ifeq ($(TARGET_USE_HWCOMPOSER_VHAL), true)
PRODUCT_COPY_FILES += \
    vendor/intel/cic/target/graphics/edge/system/vendor/lib/hw/hwcomposer.remote.so:system/vendor/lib/hw/hwcomposer.remote.so \
    vendor/intel/cic/target/graphics/edge/system/vendor/lib64/hw/hwcomposer.remote.so:system/vendor/lib64/hw/hwcomposer.remote.so
else
PRODUCT_PACKAGES += hwcomposer.intel
endif


PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=intel \
    ro.hardware.gralloc_imp=intel \
    ro.opengles.version=196610

ifeq ($(TARGET_USE_HWCOMPOSER_VHAL), true)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=remote
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=intel
endif

