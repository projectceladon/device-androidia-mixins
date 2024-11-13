LOCAL_NPU_FIRMWARE_DIR := hardware/intel/external/linux-npu-driver/firmware/bin

PRODUCT_COPY_FILES += \
    $(LOCAL_NPU_FIRMWARE_DIR)/vpu_37xx_v0.0.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/vpu/vpu_37xx_v0.0.bin \
    $(LOCAL_NPU_FIRMWARE_DIR)/vpu_40xx_v0.0.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/vpu/vpu_40xx_v0.0.bin

PRODUCT_PACKAGES += \
    libnpu_driver_compiler \
    libze_loader \
    libze_intel_vpu \

PRODUCT_PACKAGES += \
    libc++_shared \
    libopenvino \
    libopenvino_intel_gpu_plugin \
    libopenvino_intel_npu_plugin \
    libopenvino_ir_frontend \
    libopenvino_tensorflow_lite_frontend

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    benchmark_app \
    hello_query_device
endif
