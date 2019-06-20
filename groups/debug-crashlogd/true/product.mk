ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/{{_extra_dir}}/init.crashlogd.rc:root/init.crashlogd.rc \
	$(call add-to-product-copy-files-if-exists,$(LOCAL_PATH)/{{_extra_dir}}/ingredients.conf:$(TARGET_COPY_OUT_VENDOR)/etc/ingredients.conf) \
	$(call add-to-product-copy-files-if-exists,$(LOCAL_PATH)/{{_extra_dir}}/crashlog.conf:$(TARGET_COPY_OUT_VENDOR)/etc/crashlog.conf)
PRODUCT_PACKAGES += crashlogd \
	dumpstate_dropbox.sh
endif

ifeq ($(MIXIN_DEBUG_LOGS),true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += persist.vendor.crashlogd.data_quota=50
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/crashlogd

CRASHLOGD_LOGS_PATH := "/data/logs"
CRASHLOGD_APLOG := true
CRASHLOGD_FULL_REPORT := true
CRASHLOGD_MODULE_MODEM ?= true
{{#binder}}
CRASHLOGD_MODULE_BINDER := {{{binder}}}
{{/binder}}
{{#btdump}}
CRASHLOGD_MODULE_BTDUMP := {{{btdump}}}
{{/btdump}}
CRASHLOGD_USE_SD := false
{{#arch}}
CRASHLOGD_ARCH := {{{arch}}}
{{/arch}}
{{#ssram_crashlog}}
CRASHLOGD_SSRAM_CRASHLOG := {{{ssram_crashlog}}}
{{/ssram_crashlog}}
{{#ramdump}}
CRASHLOGD_RAMDUMP := {{{ramdump}}}
{{/ramdump}}
endif
