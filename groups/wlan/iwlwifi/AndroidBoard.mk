{{^iwl_upstream_drv}}
LOCAL_KERNEL_PATH := $(abspath $(PRODUCT_OUT)/obj/kernel) is not defined yet
$(abspath $(PRODUCT_OUT)/obj/kernel)/copy_modules: iwlwifi
{{/iwl_upstream_drv}}
