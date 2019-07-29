BOARD_KERNEL_CMDLINE += \
	apic=sofia \
	vmalloc=288M \
	slub_max_order=0

ifneq (,$(filter eng userdebug,$(TARGET_BUILD_VARIANT)))
BOARD_KERNEL_CMDLINE += \
	console=tdcons
endif # TARGET_BUILD_VARIANT is eng, userdebug

