ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=ttyS0,115200n8 console=ttyS1,115200n8
endif
