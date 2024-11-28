ifeq ($(TARGET_BOARD_PLATFORM),)
    $(error Please define TARGET_BOARD_PLATFORM in product-level Makefile)
endif

# Sensors HAL modules
PRODUCT_PACKAGES += \
	android.hardware.sensors@aidl-service.intel

{{#enable_sensor_list}}
AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in
{{/enable_sensor_list}}
