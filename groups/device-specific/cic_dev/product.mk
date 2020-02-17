PRODUCT_PACKAGES += \
    docker \
    cpio \
    aic-build \

PRODUCT_PACKAGES += \
    sh_vendor \
    vintf \
    toybox_vendor \
    sdcard-fuse \

PRODUCT_COPY_FILES += \
    out/target/product/$(TARGET_PRODUCT)/system/bin/sdcard-fuse:system/bin/sdcard

PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \

PRODUCT_PROPERTY_OVERRIDES += \
    service.adb.tcp.port=5555
