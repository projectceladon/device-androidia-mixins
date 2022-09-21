PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libGLES_android \
    libigdrcl \
    libOpenCL \
    libcommon_clang \
    libigc \
    libigdfcl

#Gallium drivers since mesa 22.0.3
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi
#Vulkan driver since mesa 22.0.3
PRODUCT_PACKAGES += \
    vulkan.intel

#Keep legacy mesa driver for compatibility
PRODUCT_PACKAGES += \
    libGLES_mesa

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync
#   libmd
#Epic mdapi was deprecated for TGL and ADL platform
#So disable libmd and leave mdapi compiling issue with mesa 22.0.3

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
    hwcomposer.drm_minigbm \
    hwcomposer.ranchu

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=ranchu

{{#minigbm}}
# Mini gbm
PRODUCT_PACKAGES += \
    gralloc.$(TARGET_GFX_INTEL)

PRODUCT_PACKAGES += \
    TencentIME \
    vinput \
    LauncherEx \
    gralloc.tencent \
    libGLESv1_CM_emulation \
    lib_renderControl_enc \
    libEGL_emulation \
    libGLESv2_enc \
    libOpenglSystemCommon \
    libGLESv2_emulation \
    libGLESv1_enc

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=tencent
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
    vulkan.pastel \
    vulkan.ranchu
{{/vulkan}}
