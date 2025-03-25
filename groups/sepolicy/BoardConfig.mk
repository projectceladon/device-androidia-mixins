# SELinux Policy
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)

# Pass device target to build in
BOARD_SEPOLICY_M4DEFS += board_sepolicy_target_product=$(TARGET_PRODUCT)

SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/system_ext/public
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/system_ext/private
