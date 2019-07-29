BOARD_KERNEL_CMDLINE += \
	idle=halt \
	debug \
	notsc \
	nolapic_pm \
	apic=sofia \
	cma={{{cma_size}}} \
	nolapic_timer \
	x86_intel_xgold_timer=soctimer_only \
	slub_max_order=0

ifneq (,$(filter eng userdebug,$(TARGET_BUILD_VARIANT)))
BOARD_KERNEL_CMDLINE += \
	console=ttyS0,115200n8 \
	earlyprintk={{{earlyprintk}}}
endif # TARGET_BUILD_VARIANT is eng, userdebug

# Device Tree Blob file name:
BOARD_DTB_FILE ?= {{{board_dtb}}}

# Device cache size value:
BOARD_SHARED_CACHE_SIZE := 512*1024
BOARD_DATA_CACHE_SIZE := 16*1024

YOCTO_TOOLCHAIN_REQUIRED_VERSION := 1.6
