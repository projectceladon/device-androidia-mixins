DOCKERD_ENV_RESOLV_CONF := $(PRODUCT_OUT)/system/etc/resolv.conf
$(DOCKERD_ENV_RESOLV_CONF):
	@ln -sf /data/docker/etc/resolv.conf $(PRODUCT_OUT)/system/etc/resolv.conf
$(PRODUCT_OUT)/system.img:  $(DOCKERD_ENV_RESOLV_CONF)

LIC_IMAGE_SOURCE := $(PRODUCT_OUT)/vendor/etc/docker/weston-in-docker.tar
$(LIC_IMAGE_SOURCE):
	@mkdir -p $(PRODUCT_OUT)/vendor/etc/docker
	@tar --exclude .git -cf $(PRODUCT_OUT)/vendor/etc/docker/weston-in-docker.tar -C $(TOP)/vendor/intel/weston-in-docker/ .
$(PRODUCT_OUT)/vendor.img: $(LIC_IMAGE_SOURCE)
