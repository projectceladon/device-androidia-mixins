{{#gen9+}}

I915_FW_PATH := vendor/linux/firmware/i915

#list of i915/huc_xxx.bin i915/dmc_xxx.bin i915/guc_xxx.bin
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/kbl*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/bxt*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/cml*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/ehl*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/tgl*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/adl*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/dg2*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/mtl*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))

$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/compat*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/intel_vsec*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))
$(foreach t, $(patsubst $(I915_FW_PATH)/%,%,$(wildcard $(I915_FW_PATH)/i915_ag*)) ,$(eval I915_FW += i915/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/i915/$(t)))

_EXTRA_FW_ += $(I915_FW)

XE_FW_PATH := vendor/linux/firmware/xe
$(foreach t, $(patsubst $(XE_FW_PATH)/%,%,$(wildcard $(XE_FW_PATH)/lnl*)) ,$(eval XE_FW += xe/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/xe/$(t)))
$(foreach t, $(patsubst $(XE_FW_PATH)/%,%,$(wildcard $(XE_FW_PATH)/ptl*)) ,$(eval XE_FW += xe/$(t)) $(eval $(LOCAL_KERNEL) : $(PRODUCT_OUT)/vendor/firmware/xe/$(t)))
_EXTRA_FW_ += $(XE_FW)

AUTO_IN += $(TARGET_DEVICE_DIR)/{{_extra_dir}}/auto_hal.in

{{/gen9+}}

