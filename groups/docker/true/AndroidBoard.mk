DOCKERD_ENV_RESOLV_CONF := $(PRODUCT_OUT)/system/etc/resolv.conf
$(DOCKERD_ENV_RESOLV_CONF):
	@ln -sf /data/vendor/docker/etc/resolv.conf $(PRODUCT_OUT)/system/etc/resolv.conf
$(PRODUCT_OUT)/system.img:  $(DOCKERD_ENV_RESOLV_CONF)

LIC_IMAGE_SOURCE := $(PRODUCT_OUT)/vendor/etc/docker/gamecore.tar
$(LIC_IMAGE_SOURCE):
	@mkdir -p $(PRODUCT_OUT)/vendor/etc/docker
ifneq ($(wildcard $(TOP)/vendor/intel/weston-in-docker/image),)
	@cp -r $(TOP)/vendor/intel/weston-in-docker/image $(PRODUCT_OUT)/vendor/etc/docker/
endif
ifneq ($(wildcard $(TOP)/vendor/intel/weston-in-docker/gamecore),)
	@tar --exclude .git -cf $(PRODUCT_OUT)/vendor/etc/docker/gamecore.tar -C $(TOP)/vendor/intel/weston-in-docker/gamecore .
endif
ifneq ($(wildcard $(TOP)/vendor/intel/weston-in-docker/aicore),)
	@tar --exclude .git -cf $(PRODUCT_OUT)/vendor/etc/docker/aicore.tar -C $(TOP)/vendor/intel/weston-in-docker/aicore .
endif
$(PRODUCT_OUT)/vendor.img: $(LIC_IMAGE_SOURCE)
