.PHONY: multidroid
multidroid: droid
	@echo Make multidroid image...
	$(hide) rm -rf $(PRODUCT_OUT)/docker
	$(hide) mkdir -p $(PRODUCT_OUT)/docker/android/root
	$(hide) cp -r $(TOP)/$(INTEL_PATH_VENDOR_CIC)/host/docker/aic-manager $(PRODUCT_OUT)/docker
	$(hide) cp -r $(TOP)/$(INTEL_PATH_KERNEL_MODULES_CIC)/ashmem $(PRODUCT_OUT)/docker/aic-manager/data/
	$(hide) cp -r $(TOP)/$(INTEL_PATH_KERNEL_MODULES_CIC)/binder $(PRODUCT_OUT)/docker/aic-manager/data/
	$(hide) cp -r $(TOP)/$(INTEL_PATH_KERNEL_MODULES_CIC)/mac80211_hwsim $(PRODUCT_OUT)/docker/aic-manager/data/
	$(hide) cp -r $(TOP)/$(INTEL_PATH_VENDOR_CIC)/host/docker/android $(PRODUCT_OUT)/docker
	$(hide) cp -r $(TOP)/$(INTEL_PATH_VENDOR_CIC)/host/docker/update $(PRODUCT_OUT)/docker
	$(hide) cp $(TOP)/$(INTEL_PATH_VENDOR_CIC)/host/docker/scripts/aic $(PRODUCT_OUT)
	$(hide) cp -r $(PRODUCT_OUT)/system $(PRODUCT_OUT)/docker/android/root
	$(hide) cp -r $(PRODUCT_OUT)/root/* $(PRODUCT_OUT)/docker/android/root
	$(hide) rm -f $(PRODUCT_OUT)/docker/android/root/etc
	$(hide) cp -r $(PRODUCT_OUT)/system/etc $(PRODUCT_OUT)/docker/android/root
	$(hide) chmod -R g-w $(PRODUCT_OUT)/docker/android/root

TARGET_AIC_FILE_NAME := $(TARGET_PRODUCT)-aic-$(BUILD_NUMBER_FROM_FILE).tar.gz

.PHONY: aic
aic: .KATI_NINJA_POOL := console
aic: multidroid
	@echo Make AIC docker images...
	$(HOST_OUT_EXECUTABLES)/aic-build -b $(BUILD_NUMBER_FROM_FILE)
	tar cvzf $(PRODUCT_OUT)/$(TARGET_AIC_FILE_NAME) -C $(PRODUCT_OUT) aic android.tar.gz aic-manager.tar.gz -C docker update

.PHONY: cic
cic: aic
