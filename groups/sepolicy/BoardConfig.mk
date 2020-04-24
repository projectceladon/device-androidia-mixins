# SELinux Policy
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)

BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

# Pass device target to build in
BOARD_SEPOLICY_M4DEFS += board_sepolicy_target_product=$(TARGET_PRODUCT)
