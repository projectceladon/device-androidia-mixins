# There is a strong dependency on debug-logs; disable debug-npk if not set
ifeq ($(MIXIN_DEBUG_LOGS),true)

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.npk.rc:root/init.npk.rc \
    {{{npk_cfg_path}}}/npk.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/npk.cfg
PRODUCT_PACKAGES += \
    npk_init \
    logd2sven

endif #MIXIN_DEBUG_LOGS

# There is a strong dependency on debug-logs; disable debug-npk if not set
ifeq ($(MIXIN_DEBUG_LOGS),true)

# Enable redirection of android logs to SVENTX
LOGCATEXT_USES_SVENTX := true
BOARD_SEPOLICY_DIRS += \
    device/intel/sepolicy/debug-npk

ifeq ($(PSTORE_CONFIG),PRAM)

# Default configuration for dumps to pstore
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.npk.cfg={{default_cfg}}

# Increase pstore dump size to fit MSC buffers
BOARD_KERNEL_CMDLINE += \
    intel_pstore_pram.record_size=524288 \
    pstore.extra_size=524288

endif # PSTORE_CONFIG == PRAM

endif #MIXIN_DEBUG_LOGS
