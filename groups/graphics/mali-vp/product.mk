PRODUCT_PACKAGES += \
    libGLES_android \
    egl.cfg \
    gralloc.$(TARGET_BOARD_PLATFORM) \
    hwcomposer.$(TARGET_BOARD_PLATFORM) \
    hwcomposer.default \
    libion

BOARD_EGL_CFG := $(INTEL_PATH_COMMON)/graphics/mali-vp/egl.cfg

# Intel Hardwarecompose
FEAT_INTEL_HWC := true
#TODO: for Sofia
# Temporary remove Camera
BUILD_IMC_STAGEFRIGHT_CODEC := false

TARGET_DISABLE_TRIPLE_BUFFERING := false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version = 131072 \
    debug.hwui.render_dirty_regions = false

PRODUCT_PROPERTY_OVERRIDES += ro.kernel.qemu=1
PRODUCT_PROPERTY_OVERRIDES += ro.kernel.qemu.gles=0
