KERNEL_cvmb_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/cvmb_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_cvmb_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

LOCAL_CLANG_PATH = $(CLANG_PREBUILTS_PATH)/host/$(HOST_OS)-x86/$(KERNEL_CLANG_VERSION)/bin

LOCAL_MAKE:= \
        PATH="$(LOCAL_CLANG_PATH):$(PWD)/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8/x86_64-linux/bin:$$PATH" \
	$(PWD)/prebuilts/build-tools/linux-x86/bin/make

# SKip host-pkg release, host-pkg PHONY is required by flashfiles PHONY
PHONY: host-pkg
host-pkg:
	echo "Skip host package release for cvmb"
