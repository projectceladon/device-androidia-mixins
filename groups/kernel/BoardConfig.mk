# Specify location of board-specific kernel headers
ifeq ($(BASE_LTS2023_CHROMIUM_KERNEL), true)
  TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/{{{lts2023_chromium_src_path}}}/kernel-headers
else ifeq ($(BASE_LINUX_INTEL_LTS2023_KERNEL), true)
  TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/{{{linux_intel_lts2023_src_path}}}/kernel-headers
else ifeq ($(BASE_LTS2024_ANDROID_KERNEL), true)
  TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/{{{lts2024_android_src_path}}}/kernel-headers
else
  TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/{{{src_path}}}/kernel-headers
endif

ifeq ($(TARGET_PREBUILT_KERNEL), true)
BOARD_VENDOR_KERNEL_MODULES := \
        $(wildcard $(PREBUILT_KERNEL_ROOT)/vendor_dlkm/*.ko)
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
KERNEL_LOGLEVEL ?= {{{loglevel}}}
else
KERNEL_LOGLEVEL ?= {{{user_loglevel}}}
endif

ifeq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=tty0
endif

BOARD_KERNEL_CMDLINE += \
        loglevel=$(KERNEL_LOGLEVEL) \
        firmware_class.path={{{firmware_path}}}

ifeq ($(BOOTCONFIG_ENABLE), true)
BOARD_BOOTCONFIG += androidboot.hardware=$(TARGET_DEVICE)
else
BOARD_KERNEL_CMDLINE += androidboot.hardware=$(TARGET_DEVICE)
endif
{{#boot_boost}}

BOARD_KERNEL_CMDLINE += \
        bootboost=1
{{/boot_boost}}

{{#pmsuspend_debug}}
BOARD_KERNEL_CMDLINE += \
        pm_suspend_debug=1
{{/pmsuspend_debug}}
{{#memory_hole}}
BOARD_KERNEL_CMDLINE += \
        memmap=4M\$$0x5c400000
{{/memory_hole}}
{{#interactive_governor}}
BOARD_KERNEL_CMDLINE += \
	intel_pstate=disable
{{/interactive_governor}}
{{#relative_sleepstates}}

BOARD_KERNEL_CMDLINE += \
        relative_sleep_states=1
{{/relative_sleepstates}}

{{#schedutil}}
BOARD_KERNEL_CMDLINE += \
       intel_pstate=passive
{{/schedutil}}

BOARD_KERNEL_CMDLINE += \
      clearcpuid=517 \
      mce=no_lmce \
      mce=ignore_ce

BOARD_SEPOLICY_M4DEFS += module_kernel=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/kernel
