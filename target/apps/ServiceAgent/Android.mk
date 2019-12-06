LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := $(call all-java-files-under,src) $(call all-Iaidl-files-under,src)
#LOCAL_JAVA_LIBRARIES := framework
LOCAL_PACKAGE_NAME := ServiceAgent
LOCAL_SDK_VERSION := current
LOCAL_PROGUARD_ENABLED := disabled
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
include $(BUILD_PACKAGE)
