# disable debug boot image for GSI testing
# For Generic Kernel Image (GKI) using devices that have a vendor_boot partition,
# boot-debug.img mustn't be flashed, as the boot partition must be flashed with
# a certified GKI image. Instead vendor_boot-debug.img should be flashed
# onto the vendor_boot partition in order to facilitate debug ramdisk.
PRODUCT_BUILD_DEBUG_BOOT_IMAGE := true
