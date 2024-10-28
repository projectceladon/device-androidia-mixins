LOCAL_NPU_FIRMWARE_DIR := hardware/intel/external/linux-npu-driver/firmware/bin

PRODUCT_COPY_FILES += \
    $(LOCAL_NPU_FIRMWARE_DIR)/vpu_37xx_v0.0.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/vpu/vpu_37xx_v0.0.bin \
    $(LOCAL_NPU_FIRMWARE_DIR)/vpu_40xx_v0.0.bin:$(TARGET_COPY_OUT_VENDOR)/firmware/intel/vpu/vpu_40xx_v0.0.bin
