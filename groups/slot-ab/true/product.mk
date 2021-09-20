PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier \
    libavb \
    update_engine_sideload \
    avbctl \
    android.hardware.boot@1.2-impl-intel \
    android.hardware.boot@1.2-impl-intel.recovery \
    android.hardware.boot@1.2-service \
    bootctrl.intel

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.bootctrl=intel

PRODUCT_PACKAGES_DEBUG += \
    bootctl

PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:vendor/bin/postinstall
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/postinstall.sh:recovery/root/vendor/bin/postinstall
