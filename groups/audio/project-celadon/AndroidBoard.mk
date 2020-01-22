pfw_rebuild_settings := true
# Target specific audio configuration files
include $(TARGET_DEVICE_DIR)/audio/parameter-framework/AndroidBoard.mk
##################################################
# Audio policy files
#
include $(CLEAR_VARS)
LOCAL_MODULE := meta.audio_policy_configuration.default
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := \
    audio_policy_volumes.xml \
    default_volume_tables.xml \
    r_submix_audio_policy_configuration.xml \
    usb_audio_policy_configuration.xml \
    a2dp_audio_policy_configuration.xml
include $(BUILD_PHONY_PACKAGE)
##################################################
# The audio meta package

include $(CLEAR_VARS)
LOCAL_MODULE := meta.package.audio
LOCAL_MODULE_TAGS := tests

LOCAL_REQUIRED_MODULES := \
    audio_hal_configurable \
    meta.audio_policy_configuration.default \
    parameter-framework.audio.celadon \
    parameter-framework.route.celadon \
    audio.r_submix.default \
    audio.usb.default \
    parameter-framework.policy

include $(BUILD_PHONY_PACKAGE)


