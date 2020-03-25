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

ifeq ($(TARGET_DM_VERITY_SUPPORT), true)
PRODUCT_PACKAGES += \
    build_verity_img.py \
    cic_veritysetup

INSTALLED_VERITY_METADATA_IMG := out/target/product/$(TARGET_PRODUCT)/verity_metadata
INSTALLED_VERITY_SETUP_TOOL := out/host/linux-x86/bin/cic_veritysetup
endif

PRODUCT_PROPERTY_OVERRIDES += \
    service.adb.tcp.port=5555
