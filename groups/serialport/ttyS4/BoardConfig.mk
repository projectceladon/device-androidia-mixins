ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=ttyS4,115200n8
endif
