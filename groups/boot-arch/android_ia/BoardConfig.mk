# Kernel Flinger
TARGET_UEFI_ARCH := x86_64
# Kernelflinger won't check the ACPI table oem_id, oem_table_id and
# revision fields
KERNELFLINGER_ALLOW_UNSUPPORTED_ACPI_TABLE := true
# Allow Kernelflinger to start watchdog prior to boot the kernel
KERNELFLINGER_USE_WATCHDOG := true
# Tell Kernelflinger to ignore ACPI RSCI table
KERNELFLINGER_IGNORE_RSCI := true
KERNELFLINGER_SSL_LIBRARY := boringssl
# Specify system verity partition
#PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/by-name/system
