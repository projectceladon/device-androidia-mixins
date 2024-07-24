BUILD_CPU_ARCH ?= silvermont

# Items that are common between slm 32b and 64b:
TARGET_ARCH_VARIANT := $(if $(BUILD_CPU_ARCH),$(BUILD_CPU_ARCH),x86)
TARGET_CPU_VARIANT := generic
TARGET_CPU_SMP := true

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
# 64b-specific items:
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
else
# 32b-specific items:
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
endif
