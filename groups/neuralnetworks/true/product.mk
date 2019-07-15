# neuralnetworks HAL
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.0-service-gpgpu \
    android.hardware.neuralnetworks@1.0-mkldnn-service

PRODUCT_PACKAGES += \
    libinference_engine

PRODUCT_PACKAGES += \
    libmkldnn

PRODUCT_PACKAGES += \
    graphtest_cpu

PRODUCT_PROPERTY_OVERRIDES += debug.nn.vlog=0
PRODUCT_PROPERTY_OVERRIDES += debug.nn.cpuonly=0
PRODUCT_PROPERTY_OVERRIDES += debug.nn.partition=1
