.PHONY: multidroid
multidroid: droid
	@echo Make multidroid image...
	$(hide) rm -rf $(PRODUCT_OUT)/docker
	$(hide) mkdir -p $(PRODUCT_OUT)/docker/android/root
	$(hide) cp -r $(TOP)/vendor/intel/cic/host/docker/aic-manager $(PRODUCT_OUT)/docker
	$(hide) mkdir -p $(PRODUCT_OUT)/docker/aic-manager/data
	$(hide) cp -r $(TOP)/kernel/modules/cic/ashmem $(PRODUCT_OUT)/docker/aic-manager/data/
	$(hide) cp -r $(TOP)/kernel/modules/cic/binder $(PRODUCT_OUT)/docker/aic-manager/data/
	$(hide) cp -r $(TOP)/vendor/intel/cic/host/docker/android $(PRODUCT_OUT)/docker
	$(hide) cp -r $(TOP)/vendor/intel/cic/host/docker/update $(PRODUCT_OUT)/docker
	$(hide) cp -r $(TOP)/vendor/intel/cic/host/k8s/client/AIC-release-v0.38-c1f590d2.apk $(PRODUCT_OUT)
	$(hide) chmod -R g-w $(PRODUCT_OUT)/docker/update
	$(hide) cp -r $(TOP)/vendor/intel/cic/host/k8s/image/manage-android $(PRODUCT_OUT)/docker
	$(hide) cp -r $(TOP)/vendor/intel/external/project-celadon/cloud-streaming $(PRODUCT_OUT)/docker/ga
	$(hide) cp $(TOP)/vendor/intel/cic/host/docker/scripts/aic $(PRODUCT_OUT)
	$(hide) cp $(TOP)/vendor/intel/cic/host/docker/scripts/aic-app $(PRODUCT_OUT)
	$(hide) cp $(HOST_OUT_EXECUTABLES)/aic-build $(PRODUCT_OUT)
	$(hide) cp /usr/libexec/docker/docker-init $(PRODUCT_OUT)/docker/aic-manager/

ifneq ($(TARGET_LOOP_MOUNT_SYSTEM_IMAGES), true)
	$(hide) cp -r $(PRODUCT_OUT)/system $(PRODUCT_OUT)/docker/android/root
	$(hide) cp -r $(PRODUCT_OUT)/root/* $(PRODUCT_OUT)/docker/android/root
	$(hide) rm -f $(PRODUCT_OUT)/docker/android/root/etc
	$(hide) cp -r $(PRODUCT_OUT)/system/etc $(PRODUCT_OUT)/docker/android/root
	$(hide) chmod -R g-w $(PRODUCT_OUT)/docker/android/root
else
	$(hide) zcat $(PRODUCT_OUT)/ramdisk.img | (cd $(PRODUCT_OUT)/docker/android/root && cpio -idm)
	$(hide) rm -rf $(PRODUCT_OUT)/docker/android/root/etc
	$(hide) cp -r $(PRODUCT_OUT)/system/etc $(PRODUCT_OUT)/docker/android/root
	$(hide) rm -rf $(PRODUCT_OUT)/docker/aic-manager/images
	$(hide) mkdir -p $(PRODUCT_OUT)/docker/aic-manager/images
	$(hide) ln -t $(PRODUCT_OUT)/docker/aic-manager/images $(PRODUCT_OUT)/system.img
endif

TARGET_AIC_FILE_NAME := $(TARGET_PRODUCT)-aic-$(FILE_NAME_TAG).tar.gz
TARGET_K8S_FILE_NAME := $(TARGET_PRODUCT)-k8s-$(FILE_NAME_TAG).tar.gz
TARGET_ESC_FILE_NAME := $(TARGET_PRODUCT)-esc-$(FILE_NAME_TAG).tar.gz

ifeq ($(PUBLISH_ANDROID_CLOUD_TAG),)
AIC_PUBLISH_OPTION = -t $(FILE_NAME_TAG)
else
AIC_PUBLISH_OPTION = -t $(PUBLISH_ANDROID_CLOUD_TAG)
endif
ifneq ($(PUBLISH_ANDROID_CLOUD_REGISTRY),)
AIC_PUBLISH_OPTION += -r $(PUBLISH_ANDROID_CLOUD_REGISTRY)
endif

.PHONY: publish_android_cloud
publish_android_cloud: .KATI_NINJA_POOL := console
publish_android_cloud: multidroid
ifneq ($(PUBLISH_ANDROID_CLOUD),)
	DOCKER_HOST=$(DOCKER_HOST) $(HOST_OUT_EXECUTABLES)/aic-publish $(AIC_PUBLISH_OPTION) $(PRODUCT_OUT)/docker
endif

.PHONY: aic
aic: .KATI_NINJA_POOL := console
aic: multidroid
	@echo Make AIC docker images...
ifneq ($(TARGET_LOOP_MOUNT_SYSTEM_IMAGES), true)
	DOCKER_HOST=$(DOCKER_HOST) $(HOST_OUT_EXECUTABLES)/aic-build android -b $(FILE_NAME_TAG)
else
	DOCKER_HOST=$(DOCKER_HOST) BUILD_VARIANT=loop_mount $(HOST_OUT_EXECUTABLES)/aic-build android -b $(FILE_NAME_TAG)
endif

ifneq ($(TARGET_BUILD_AIC_MANAGER_DOCKER), true)
	DOCKER_HOST=$(DOCKER_HOST) tar cvzf $(PRODUCT_OUT)/$(TARGET_AIC_FILE_NAME) -C $(PRODUCT_OUT) aic aic-app AIC-release-v0.38-c1f590d2.apk android.tar.gz aic-build -C docker update aic-manager
else
	DOCKER_HOST=$(DOCKER_HOST) tar cvzf $(PRODUCT_OUT)/$(TARGET_AIC_FILE_NAME) -C $(PRODUCT_OUT) aic aic-app AIC-release-v0.38-c1f590d2.apk android.tar.gz aic-manager.tar.gz -C docker update
endif

.PHONY: k8s
k8s: multidroid
	@echo Make k8s package for AIC...
	$(TOP)/vendor/intel/cic/host/k8s/script/gen-rel-pkg -f -n $(TARGET_K8S_FILE_NAME:.tar.gz=)

.PHONY: cic
cic: aic
cic: k8s

.PHONY: esc
esc: cic
	$(hide) rm -rf $(PRODUCT_OUT)/esc-release
	$(hide) mkdir -p $(PRODUCT_OUT)/esc-release/release $(PRODUCT_OUT)/esc-release/image/update
	$(hide) cp -r $(PRODUCT_OUT)/release/tool $(PRODUCT_OUT)/release/coturn $(PRODUCT_OUT)/release/coordinator $(PRODUCT_OUT)/release/k8s  $(PRODUCT_OUT)/release/owt-server-p2p $(PRODUCT_OUT)/release/dg2-streamer $(PRODUCT_OUT)/release/icr $(PRODUCT_OUT)/release/webrtc-front-end $(PRODUCT_OUT)/esc-release/release/.
	$(hide) cp -r $(PRODUCT_OUT)/aic $(PRODUCT_OUT)/aic-app $(PRODUCT_OUT)/AIC-release-v0.38-c1f590d2.apk $(PRODUCT_OUT)/aic-manager.tar.gz $(PRODUCT_OUT)/android.tar.gz $(PRODUCT_OUT)/cpuAllocate $(PRODUCT_OUT)/esc-release/image/.
	$(hide) cp -r $(PRODUCT_OUT)/docker/update/pkg.d/106-dg2-drivers/root $(PRODUCT_OUT)/esc-release/image/update/.
	$(hide) cp -r $(PRODUCT_OUT)/docker/update/Dockerfile $(PRODUCT_OUT)/docker/update/core $(PRODUCT_OUT)/docker/update/default.prop $(PRODUCT_OUT)/docker/update/env-var $(PRODUCT_OUT)/docker/update/post-update $(PRODUCT_OUT)/docker/update/pre-update $(PRODUCT_OUT)/docker/update/system.prop $(PRODUCT_OUT)/docker/update/to-del.list $(PRODUCT_OUT)/docker/update/to-mod.list $(PRODUCT_OUT)/esc-release/image/update/.
	$(hide) cat $(PRODUCT_OUT)/docker/update/pkg.d/106-dg2-drivers/system.prop >> $(PRODUCT_OUT)/esc-release/image/update/system.prop
	$(hide) tar cvzf $(PRODUCT_OUT)/esc-release/$(TARGET_AIC_FILE_NAME) -C $(PRODUCT_OUT)/esc-release/image aic aic-app AIC-release-v0.38-c1f590d2.apk aic-manager.tar.gz android.tar.gz cpuAllocate update
	$(hide) tar cvzf $(PRODUCT_OUT)/$(TARGET_ESC_FILE_NAME) -C $(PRODUCT_OUT)/esc-release release $(TARGET_AIC_FILE_NAME)

PUB_SYSTEM_SYMBOLS := symbols.tar.gz

.PHONY: publish_ci
publish_ci: cic publish_android_cloud
	@echo Publish CI AIC docker images...
	$(hide) mkdir -p $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	$(hide) cp $(PRODUCT_OUT)/$(TARGET_AIC_FILE_NAME) $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	$(hide) cp $(PRODUCT_OUT)/$(TARGET_K8S_FILE_NAME) $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	tar --checkpoint=1000 --checkpoint-action=dot -czf $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)/$(PUB_SYSTEM_SYMBOLS) $(PRODUCT_OUT)/symbols

# Following 1A CI practice, "publish" is used by buildbot for "latest", "release", etc. Without this
# target, the build will fail on related buildbot.
# Currently, the "publish" and "publish_ci" are the same. But they may be different in the future.
.PHONY: publish
publish: cic publish_android_cloud
	@echo Publish AIC docker images...
	$(hide) mkdir -p $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	$(hide) cp $(PRODUCT_OUT)/$(TARGET_AIC_FILE_NAME) $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	$(hide) cp $(PRODUCT_OUT)/$(TARGET_K8S_FILE_NAME) $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	tar --checkpoint=1000 --checkpoint-action=dot -czf $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)/$(PUB_SYSTEM_SYMBOLS) $(PRODUCT_OUT)/symbols

.PHONY: publish_esc
publish_esc: esc
	$(hide) mkdir -p $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
	$(hide) cp $(PRODUCT_OUT)/$(TARGET_ESC_FILE_NAME) $(TOP)/pub/$(TARGET_PRODUCT)/$(TARGET_BUILD_VARIANT)
