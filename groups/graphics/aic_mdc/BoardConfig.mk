# Build and enable the OpenGL ES View renderer. When running on the emulator,
# the GLES renderer disables itself if host GL acceleration isn't available.
USE_OPENGL_RENDERER := true

# framework switches 
TARGET_USES_HWC2 			:= true
USE_OPENGL_RENDERER 		:= true
TARGET_HARDWARE_3D 			:= true

# global switches to use old gfx stack or master gfx stack
TARGET_USE_INTEL_LIBDRM 	:= true
TARGET_USE_INTEL_MESA 		:= true
TARGET_USE_INTEL_GRALLOC	:= true
TARGET_USE_INTEL_HWCOMPOSER	:= false

# multidroid vhal switches
TARGET_USE_GRALLOC_VHAL		:= false
TARGET_USE_HWCOMPOSER_VHAL	:= true

# components specific switches
ifeq ($(TARGET_USE_INTEL_LIBDRM), true)
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= intel
else
TARGET_USE_PRIVATE_LIBDRM := false
endif

BOARD_USE_MESA := true
BOARD_GPU_DRIVERS := i965 iris
BOARD_USES_MINIGBM := true
INTEL_MINIGBM := external/minigbm-intel
BOARD_USES_GRALLOC1 := true

ifeq ($(TARGET_USE_INTEL_HWCOMPOSER), true)
BOARD_USES_IA_HWCOMPOSER := true
BOARD_ENABLE_EXPLICIT_SYNC := true
BOARD_CURSOR_WA := true
else
BOARD_USES_IA_HWCOMPOSER := false
BOARD_ENABLE_EXPLICIT_SYNC := false
BOARD_CURSOR_WA := false
endif

ifeq ($(TARGET_USE_INTEL_HWCOMPOSER), true)
  PRODUCT_PACKAGES += libva
endif

TARGET_DONT_USE_NATIVE_FENCE := true

VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
