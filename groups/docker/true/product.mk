PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/{{_extra_dir}}/lic_install.sh:/vendor/bin/lic_install.sh \
    $(LOCAL_PATH)/{{_extra_dir}}/docker_manager:/vendor/bin/docker_manager \
    $(LOCAL_PATH)/{{_extra_dir}}/containerd:/vendor/bin/containerd \
    $(LOCAL_PATH)/{{_extra_dir}}/containerd-shim-runc-v2:/vendor/bin/containerd-shim-runc-v2 \
    $(LOCAL_PATH)/{{_extra_dir}}/docker:/vendor/bin/docker \
    $(LOCAL_PATH)/{{_extra_dir}}/dockerd:/vendor/bin/dockerd \
    $(LOCAL_PATH)/{{_extra_dir}}/runc:/vendor/bin/runc \
    $(LOCAL_PATH)/{{_extra_dir}}/99-ignore-keyboard.rules:/vendor/etc/docker/config/99-ignore-keyboard.rules \
    $(LOCAL_PATH)/{{_extra_dir}}/99-ignore-mouse.rules:/vendor/etc/docker/config/99-ignore-mouse.rules \
    $(LOCAL_PATH)/{{_extra_dir}}/config.toml:/vendor/etc/docker/etc/containerd/config.toml \
    $(LOCAL_PATH)/{{_extra_dir}}/daemon.json:/vendor/etc/docker/etc/docker/daemon.json

PRODUCT_PACKAGES += sumClientInAndroid \
    multiplyServiceInAndroid \
    multiplyClientInAndroid \
    subtractServiceApplicationInAndroid \
    SharedBufferServiceInAndroid \
    SharedBufferClientInAndroid

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.nn.hal.grpc_socket_path=/data/vendor/neuralnetworks/ai.socket
