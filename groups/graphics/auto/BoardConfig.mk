# Use external/drm-bxt
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= intel

BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 drm.vblankoffdelay=1 i915.fastboot=1

BOARD_USE_CUSTOMIZED_MESA := true

#For mesa cross compiling with meson build system
BOARD_MESA3D_USES_MESON_BUILD := true
BOARD_MESA3D_GALLIUM_DRIVERS := virgl iris
BOARD_MESA3D_VULKAN_DRIVERS := intel

{{#minigbm}}
BOARD_USES_MINIGBM := true
BOARD_ENABLE_EXPLICIT_SYNC := true
INTEL_MINIGBM := $(INTEL_PATH_HARDWARE)/external/minigbm-intel
{{/minigbm}}

{{^minigbm}}
BOARD_USES_MINIGBM := false
BOARD_ENABLE_EXPLICIT_SYNC := false
INTEL_DRM_GRALLOC := external/drm_gralloc/
{{/minigbm}}

{{#gralloc1}}
BOARD_USES_GRALLOC1 := true
{{/gralloc1}}

{{^gralloc1}}
BOARD_USES_GRALLOC1 := false
{{/gralloc1}}

{{#mesa_sepolicy}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/mesa
{{/mesa_sepolicy}}

{{#opencl_sepolicy}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/opencl
{{/opencl_sepolicy}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/composer3

#Add app_render_setting_property folder to BOARD_SEPOLICY_DIRS
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/app_render_setting_property

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/dm_backend

BOARD_SEPOLICY_M4DEFS += module_hwc_info_service=true
