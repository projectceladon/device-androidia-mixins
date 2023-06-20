PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    libavb \
    update_engine_sideload \
    avbctl \
    android.hardware.boot-service.intel \
    android.hardware.boot-service.intel_recovery \
    android.hardware.boot-service \
    bootctrl.intel \
    bootctrl.intel.recovery

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.bootctrl=intel

PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:vendor/bin/postinstall
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:recovery/root/vendor/bin/postinstall
