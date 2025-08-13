PRODUCT_PACKAGES += \
    libGLES_android \
    libigdrcl \
    libOpenCL \
    libopencl-clang \
    libigc \
    libigdfcl \
    clinfo \
    libclvk \
    clspv \

ifeq ($(USE_PREBUILT_MESA), true)
MESA_PREBUILTS := \
    lib64/libgallium_dri.so \
    lib64/libglapi.so \
    lib64/egl/libEGL_mesa.so \
    lib64/egl/libGLESv1_CM_mesa.so \
    lib64/egl/libGLESv2_mesa.so \
    lib64/hw/vulkan.intel.so

PRODUCT_COPY_FILES += $(foreach blob, $(MESA_PREBUILTS), \
    hardware/intel/external/mesa3d-intel/prebuilts/$(blob):$(TARGET_COPY_OUT_VENDOR)/$(blob))
else
PRODUCT_PACKAGES += \
    libEGL_mesa \
    libGLESv1_CM_mesa \
    libGLESv2_mesa \
    libgallium_dri \
    libglapi \
    vulkan.intel
endif

#mesa perfetto gpu counter data producer
PRODUCT_PACKAGES += \
    libgpudataproducer \
    gpudataproducer

PRODUCT_PACKAGES += \
    libdrm \
    libdrm_intel \
    libsync

PRODUCT_PACKAGES += \
    gralloc.default

PRODUCT_PACKAGES += ufo_prebuilts

{{#use_vulkan}}
# Graphics config overrides to use vulkan
PRODUCT_VENDOR_PROPERTIES += \
    debug.renderengine.backend=skiavkthreaded \
    ro.hardware.egl=angle \
    persist.graphics.egl=angle \
    ro.gfx.angle.supported=true

# Enable HWUI Vulkan backend
TARGET_USES_VULKAN = true
{{/use_vulkan}}

#Surface Flinger related Properties

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.max_frame_buffer_acquired_buffers=3

# System's VSYNC phase offsets in nanoseconds
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_event_phase_offset_ns=7500000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.vsync_sf_event_phase_offset_ns=3000000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.enable_frame_rate_override=false

# i915 firmwares
$(foreach fw,$(I915_FW),$(eval PRODUCT_PACKAGES += $(notdir $(fw))))

# move configure files provided by intel to vendor partition
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/drirc:vendor/etc/drirc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/intel.icd:vendor/Khronos/OpenCL/vendors/intel.icd

PRODUCT_COPY_FILES += \
    vendor/intel/hardware/interfaces/graphic/dgpu-renderwlocal.cfg:vendor/etc/dgpu-renderwlocal.cfg

# DRM HWComposer
PRODUCT_PACKAGES += \
    hwcomposer.drm_minigbm

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.hwcomposer=drm_minigbm

{{#minigbm}}
# Mini gbm
PRODUCT_PACKAGES += \
    gralloc.$(TARGET_GFX_INTEL) \
    mapper.minigbm \
    libminigbm_gralloc_intel

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.gralloc=$(TARGET_GFX_INTEL)
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

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.opengles.deqp.level-2024-03-01.xml:vendor/etc/permissions/android.software.opengles.deqp.level.xml

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:vendor/etc/permissions/android.hardware.vulkan.level.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:vendor/etc/permissions/android.hardware.vulkan.compute.xml
{{/vulkan}}

{{/gen9+}}

{{#vulkan}}
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_3.xml:vendor/etc/permissions/android.hardware.vulkan.version.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.vulkan.deqp.level-2024-03-01.xml:vendor/etc/permissions/android.software.vulkan.deqp.level.xml

PRODUCT_PACKAGES += \
    vulkan.$(TARGET_BOARD_PLATFORM) \
    vulkan.pastel
{{/vulkan}}

PRODUCT_PACKAGES += \
    libEGL_angle \
    libGLESv1_CM_angle \
    libGLESv2_angle

