ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
# 64b-specific items:
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := silvermont
TARGET_2ND_CPU_VARIANT := silvermont
else
# 32b-specific items:
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
endif
# Items that are common between slm 32b and 64b:
TARGET_CPU_ABI_LIST_32_BIT := x86
TARGET_ARCH_VARIANT := silvermont
TARGET_CPU_SMP := true
