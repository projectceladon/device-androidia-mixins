# neuralnetworks HAL
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.3-generic-service \
    android.hardware.neuralnetworks@1.3-generic-impl \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/plugins.xml:vendor/etc/openvino/plugins.xml \


PRODUCT_PACKAGES += \
    libopenvino \
    libopenvino_intel_cpu_plugin \
    libopenvino_ir_frontend

PRODUCT_PROPERTY_OVERRIDES += vendor.nn.hal.ngraph=true
