BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debug-tools/androidterm

{{#logcat2hvc}}
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/logcat2hvc

BOARD_KERNEL_CMDLINE += printk.devkmsg=on
{{/logcat2hvc}}
