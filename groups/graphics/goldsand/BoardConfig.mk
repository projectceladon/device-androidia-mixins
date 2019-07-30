BOARD_KERNEL_CMDLINE += vga=current nomodeset
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_INTEL_UFO_DRIVER := false
INTEL_VA := false

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000

# Allow HWC to perform a final CSC on virtual displays
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

BOARD_GRAPHIC_IS_MALI := true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/goldsand

# Use $(INTEL_PATH_VENDOR)/external/drm-gsd
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= gsd

{{#drm_atomic}}
# Turn on DRM ATOMIC IOCTL
BOARD_KERNEL_CMDLINE += drm.atomic=1
{{/drm_atomic}}
