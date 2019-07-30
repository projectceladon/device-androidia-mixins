
BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.vblankoffdelay=1 i915.fastboot=1
USE_OPENGL_RENDERER := true
USE_INTEL_UFO_DRIVER := true
USE_INTEL_UFO_OPENCL := {{{use_opencl}}}
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
INTEL_VA := true
BOARD_GRAPHIC_IS_GEN := true

INTEL_HWC_BUILD_CONTROL_PANEL := true

# Conditional assignment to allow a target to over-ride this default
TARGET_USE_GPU_TLS_SLOTS ?= true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

BOARD_SEPOLICY_M4DEFS += module_ufo_common=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/color_config
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/ufo_common
