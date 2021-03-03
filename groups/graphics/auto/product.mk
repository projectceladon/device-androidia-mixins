PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libGLES_mesa \
    libGLES_android \
    libigdrcl \
    libOpenCL \
    libcommon_clang \
    libigc \
    libigdfcl

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync \
    libmd

PRODUCT_PACKAGES += \
    gralloc.default

PRODUCT_PACKAGES += ufo_prebuilts

#Surface Flinger related Properties

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.max_frame_buffer_acquired_buffers=3

# System's VSYNC phase offsets in nanoseconds
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_event_phase_offset_ns=7500000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_sf_event_phase_offset_ns=3000000

# i915 firmwares
$(foreach fw,$(I915_FW),$(eval PRODUCT_PACKAGES += $(notdir $(fw))))

# move configure files provided by intel to vendor partition
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/drirc:vendor/etc/drirc

# DRM HWComposer
PRODUCT_PACKAGES += \
    hwcomposer.drm_minigbm

# HWComposer IA
PRODUCT_PACKAGES += \
    hwcomposer.$(TARGET_GFX_INTEL)

# VHal
PRODUCT_PACKAGES += \
    hwcomposer.remote

INTEL_HWC_CONFIG := $(INTEL_PATH_VENDOR)/external/hwcomposer-intel

REMOTE_HWC_CONFIG := $(INTEL_PATH_VENDOR)/external/cic-graphic-vhal

ifeq ($(findstring _acrn,$(TARGET_PRODUCT)),_acrn)
PRODUCT_COPY_FILES += $(INTEL_HWC_CONFIG)/hwc_display_virt.ini:$(TARGET_COPY_OUT_VENDOR)/etc/hwc_display.ini
else
PRODUCT_COPY_FILES += $(INTEL_HWC_CONFIG)/hwc_display.ini:$(TARGET_COPY_OUT_VENDOR)/etc/hwc_display.ini
PRODUCT_COPY_FILES += $(INTEL_HWC_CONFIG)/hwc_display.kvm.ini:$(TARGET_COPY_OUT_VENDOR)/etc/hwc_display.kvm.ini
endif

PRODUCT_COPY_FILES += $(REMOTE_HWC_CONFIG)/display_settings.xml:$(TARGET_COPY_OUT_VENDOR)/etc/display_settings.xml
PRODUCT_COPY_FILES += $(REMOTE_HWC_CONFIG)/input-port-associations.xml:$(TARGET_COPY_OUT_VENDOR)/etc/input-port-associations.xml

{{#minigbm}}
# Mini gbm

PRODUCT_PACKAGES += \
    gralloc.minigbm \
    gralloc.$(TARGET_GFX_INTEL)
{{/minigbm}}

{{^minigbm}}

#Gralloc
PRODUCT_PACKAGES += \
    gralloc.drm
{{/minigbm}}

{{^gen9+}}
# GLES version. We cannot enable Android
# 3.2 support for Gen9+ devices.
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196609

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml
{{/vulkan}}

{{/gen9+}}

{{#gen9+}}
# Mesa
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:vendor/etc/permissions/android.hardware.opengles.aep.xml

# GLES version
PRODUCT_PROPERTY_OVERRIDES += \
   ro.opengles.version=196610

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml
{{/vulkan}}

{{/gen9+}}

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2020-03-01.xml:vendor/etc/permissions/android.software.vulkan.deqp.level.xml

PRODUCT_PACKAGES += \
    vulkan.$(TARGET_BOARD_PLATFORM) \
    libvulkan_intel

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.vulkan=$(TARGET_BOARD_PLATFORM)
{{/vulkan}}
