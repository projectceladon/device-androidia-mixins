PRODUCT_PACKAGES += \
    update_engine \
    update_verifier \
    update_engine_sideload \
    libavb \
    bootctrl.avb \
    bootctrl.intel \
    bootctrl.intel.static \
    android.hardware.boot@1.0-impl \
    android.hardware.boot@1.0-service

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client \
    bootctl

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.bootctrl=intel
