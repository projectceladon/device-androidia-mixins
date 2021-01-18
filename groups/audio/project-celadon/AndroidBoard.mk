pfw_rebuild_settings := true
# Target specific audio configuration files
include $(TARGET_DEVICE_DIR)/audio/AndroidBoard.mk
AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in
