{{#gen9+}}
{{^minigbm}}
I915_FW_PATH := ./$(INTEL_PATH_VENDOR)/ufo/gen9_dev/$(TARGET_ARCH)/vendor/firmware/i915
{{/minigbm}}
{{#minigbm}}
ifeq ($(TARGET_BOARD_PLATFORM),icelakeu)
	I915_FW_PATH := $(INTEL_PATH_VENDOR)/ufo/gen9_dev/x86_64_media_icl/vendor/firmware/i915
else ifeq ($(TARGET_BOARD_PLATFORM),kabylake)
	I915_FW_PATH := $(INTEL_PATH_VENDOR)/ufo/gen9_dev/x86_64_media_kbl/vendor/firmware/i915
else
	I915_FW_PATH := $(INTEL_PATH_VENDOR)/ufo/gen9_dev/x86_64_media/vendor/firmware/i915
endif
{{/minigbm}}
#list of i915/huc_xxx.bin i915/dmc_xxx.bin i915/guc_xxx.bin
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))

_EXTRA_FW_ += $(I915_FW)

AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in

{{/gen9+}}

