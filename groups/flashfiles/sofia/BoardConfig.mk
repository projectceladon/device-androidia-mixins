FLASHFILES_CONFIG ?= $(TARGET_DEVICE_DIR)/flashfiles_fls.json
USE_INTEL_FLASHFILES := true
BOARD_HAS_NO_IFWI := true
SOC_FIRMWARE_TYPE := slb
{{^fast_flashfiles}}
FAST_FLASHFILES := false
{{/fast_flashfiles}}
{{#secpack_in_slb}}
SECPACK_IN_SLB := true
{{/secpack_in_slb}}
