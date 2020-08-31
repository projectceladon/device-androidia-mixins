# celld Makefile
#
# Copyright (C) 2011-2013 Columbia University
# Author: Jeremy C. Andrus <jeremya@cs.columbia.edu>
#

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := delRedundantInput.sh
LOCAL_SRC_FILES := delRedundantInput.sh
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_MODULE_SUFFIX :=
LOCAL_BUILT_MODULE_STEM := $(notdir $(LOCAL_SRC_FILES))
include $(BUILD_PREBUILT)
