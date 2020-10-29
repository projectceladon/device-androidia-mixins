include $(CLEAR_VARS)
LOCAL_MODULE := auto_detection.sh
LOCAL_PROPRIETARY_MODULE := true
LOCAL_MODULE_OWNER := intel
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_SRC := $(AUTO_IN)
include $(BUILD_SYSTEM)/base_rules.mk
$(LOCAL_BUILT_MODULE): $(LOCAL_SRC)
	$(hide) mkdir -p "$(dir $@)"
	echo "#!/vendor/bin/sh" > $@
	cat $(AUTO_IN) >> $@
