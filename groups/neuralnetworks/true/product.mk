# neuralnetworks HAL
PRODUCT_PACKAGES += \
    android.hardware.neuralnetworks@1.0-generic-service \
    android.hardware.neuralnetworks@1.0-generic-impl \
    android.hardware.neuralnetworks@1.0-service-gpgpu

PRODUCT_PACKAGES += \
    libinference_engine

PRODUCT_PACKAGES += \
    libMKLDNNPlugin\
    libmkldnn

PRODUCT_PACKAGES += \
    graphtest_cpu

PRODUCT_PROPERTY_OVERRIDES += debug.nn.vlog=0
PRODUCT_PROPERTY_OVERRIDES += debug.nn.cpuonly=0
PRODUCT_PROPERTY_OVERRIDES += debug.nn.partition=1
