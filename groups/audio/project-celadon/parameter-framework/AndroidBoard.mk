#-------------------------------------------------------------------------
# INTEL CONFIDENTIAL
#
# Copyright 2017 Intel Corporation All Rights Reserved.
#
# This source code and all documentation related to the source code
# ("Material") contains trade secrets and proprietary and confidential
# information of Intel and its suppliers and licensors. The Material is
# deemed highly confidential, and is protected by worldwide copyright and
# trade secret laws and treaty provisions. No part of the Material may be
# used, copied, reproduced, modified, published, uploaded, posted,
# transmitted, distributed, or disclosed in any way without Intel's prior
# express written permission.
#
# No license under any patent, copyright, trade secret or other
# intellectual property right is granted to or conferred upon you by
# disclosure or delivery of the Materials, either expressly, by
# implication, inducement, estoppel or otherwise. Any license under such
# intellectual property rights must be express and approved by Intel in
# writing.
#-------------------------------------------------------------------------
#
#

PLATFORM_PFW_CONFIG_PATH := $(call my-dir)

#AUDIO_PATTERNS := @VIBRATOR_DEVICE@=/sys/devices/platform/INT34E1:00

# The file included below allows to set or not the tuning flags
# according to the type of build.
include $(INTEL_PATH_COMMON)/audio/parameter-framework/AndroidBoard.mk

#PFW_CORE := $(INTEL_PATH_VENDOR)/audio/parameter-framework
PFW_CORE := external/parameter-framework
BUILD_PFW_SETTINGS := $(PFW_CORE)/support/android/build_pfw_settings.mk

include $(PLATFORM_PFW_CONFIG_PATH)/AndroidBoard.alc286.mk

LOCAL_PATH := $(PLATFORM_PFW_CONFIG_PATH)

##################################################

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.audio.celadon
LOCAL_MODULE_TAGS := optional
# LOCAL_ADDITIONAL_DEPENDENCIES is used to ensure that the domains will be
# rebuilt if needed (LOCAL_REQUIRED_MODULES doesn't ensure that).
LOCAL_ADDITIONAL_DEPENDENCIES := \
    $(TARGET_OUT_VENDOR_ETC)/parameter-framework/Settings/Audio/AudioConfigurableDomains-alc286.xml
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := parameter-framework.route.celadon
LOCAL_MODULE_TAGS := optional
# LOCAL_ADDITIONAL_DEPENDENCIES is used to ensure that the domains will be
# rebuilt if needed (LOCAL_REQUIRED_MODULES doesn't ensure that).
LOCAL_ADDITIONAL_DEPENDENCIES := \
    $(TARGET_OUT_VENDOR_ETC)/parameter-framework/Settings/Route/RouteConfigurableDomains-alc286.xml
include $(BUILD_PHONY_PACKAGE)

######### Policy PFW top level file #########

include $(CLEAR_VARS)
LOCAL_MODULE := ParameterFrameworkConfigurationPolicy.xml
LOCAL_MODULE_STEM := ParameterFrameworkConfigurationPolicy.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_RELATIVE_PATH := parameter-framework
LOCAL_SRC_FILES := $(LOCAL_MODULE_STEM).in
include $(BUILD_PREBUILT)
