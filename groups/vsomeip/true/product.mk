PRODUCT_PACKAGES += \
    libvsomeip3 \
    libvsomeip3-cfg \
    libvsomeip3-e2e \
    libvsomeip3-sd

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    vsomeip-helloworld-client \
    vsomeip-helloworld-service

PRODUCT_COPY_FILES += \
    external/sdv/vsomeip/examples/hello_world/helloworld-local.json:vendor/etc/vsomeip/helloworld-local.json
endif
