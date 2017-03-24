ifneq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(MIXIN_DEBUG_LOGS),true)
    BOARD_SEPOLICY_DIRS += device/intel/sepolicy/log-watch
endif
endif
