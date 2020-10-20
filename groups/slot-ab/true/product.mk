PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    libavb \
    bootctrl.avb \
    bootctrl.intel \
    bootctrl.intel.static \
    bootctrl.intel.recovery \
    update_engine_sideload \
    avbctl \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-impl.recovery \
    android.hardware.boot@1.0-service

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.bootctrl=intel

PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:vendor/bin/postinstall
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:recovery/root/vendor/bin/postinstall
