# SELinux Policy
BOARD_SEPOLICY_DIRS += device/intel/project-celadon/sepolicy

# Pass device target to build
BOARD_SEPOLICY_M4DEFS += board_sepolicy_target_product=$(TARGET_PRODUCT)
