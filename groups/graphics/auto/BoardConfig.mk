# Use external/drm-bxt
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= intel

BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 drm.vblankoffdelay=1 i915.fastboot=1
{{^acrn-guest}}
{{#enable_guc}}
BOARD_KERNEL_CMDLINE += i915.enable_guc=2
{{/enable_guc}}
{{/acrn-guest}}

ifeq ($(BASE_YOCTO_KERNEL),true)
BOARD_KERNEL_CMDLINE += i915.enable_guc=2
endif

USE_OPENGL_RENDERER := true
USE_INTEL_UFO_DRIVER := false
BOARD_GPU_DRIVERS := i965 virgl iris
BOARD_USE_CUSTOMIZED_MESA := true

BOARD_GPU_DRIVERS ?= i965 swrast virgl iris
ifneq ($(strip $(BOARD_GPU_DRIVERS)),)
TARGET_HARDWARE_3D := true
TARGET_USES_HWC2 := true
endif

BOARD_USES_DRM_HWCOMPOSER := true
BOARD_USES_IA_PLANNER := true

BOARD_USES_IA_HWCOMPOSER := true

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

{{#threedis_underrun_wa}}
BOARD_THREEDIS_UNDERRUN_WA := true
{{/threedis_underrun_wa}}

{{^threedis_underrun_wa}}
BOARD_THREEDIS_UNDERRUN_WA := false
{{/threedis_underrun_wa}}

{{#coreu_msync}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/mesa
{{/coreu_msync}}

{{#mesa_acrn_sepolicy}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/mesa_acrn
{{/mesa_acrn_sepolicy}}

BOARD_SEPOLICY_M4DEFS += module_hwc_info_service=true

