pfw_rebuild_settings := true
# Target specific audio configuration files
include device/intel/project-celadon/common/audio/AndroidBoard.mk
LOAD_MODULES_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/load_audio_modules.sh
