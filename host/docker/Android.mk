LOCAL_PATH := $(call my-dir)

# host docker build helper script
include $(CLEAR_VARS)
LOCAL_MODULE := aic-build
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := scripts/aic-build
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_SUFFIX :=
LOCAL_IS_HOST_MODULE := true
LOCAL_BUILT_MODULE_STEM := $(notdir $(LOCAL_SRC_FILES))
include $(BUILD_PREBUILT)
