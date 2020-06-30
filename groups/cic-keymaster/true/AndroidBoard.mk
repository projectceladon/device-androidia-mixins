INSTALLED_CICKEYMASTERD_TARGET := $(PRODUCT_OUT)/cickeymasterd

CIC_KEYMASTER_PATH := $(TOP)/$(INTEL_PATH_VENDOR_CIC)/host/cic-keymasterd

ifeq ($(TARGET_CIC_KEYMASTER_USE_PREBUILD), true)
# cic-keymaster using the prebuild...
CIC_KEYMASTER_PREBUILD_DAEMON := $(CIC_KEYMASTER_PATH)/cickeymasterd
CIC_KEYMASTER_PREBUILS_LIB := $(CIC_KEYMASTER_PATH)/lib/keystore.cic.so
CIC_KEYMASTER_PREBUILS_LIB64 := $(CIC_KEYMASTER_PATH)/lib64/keystore.cic.so

PRODUCT_COPY_FILES += \
	$(CIC_KEYMASTER_PREBUILD_DAEMON):$(INSTALLED_CICKEYMASTERD_TARGET) \
	$(CIC_KEYMASTER_PREBUILS_LIB):system/vendor/lib/hw/keystore.cic.so \
	$(CIC_KEYMASTER_PREBUILS_LIB64):system/vendor/lib64/hw/keystore.cic.so \

else
# build from the source...
CIC_KEYMASTER_DAEMON := $(CIC_KEYMASTER_PATH)/host/build/bin/linux/cickeymasterd

aic: cickeymasterd

.PHONY: cickeymasterd
cickeymasterd:
	@echo "making cickeymasterd.."
	$(hide) mkdir -p $(CIC_KEYMASTER_PATH)/daemon/build
	$(hide) cd $(CIC_KEYMASTER_PATH)/daemon/build && cmake ../ && make
	$(hide) rm -rf $(INSTALLED_CICKEYMASTERD_TARGET)
	$(hide) cp $(CIC_KEYMASTER_DAEMON) $(INSTALLED_CICKEYMASTERD_TARGET)
endif

