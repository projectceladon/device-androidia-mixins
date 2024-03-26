PRODUCT_PACKAGES += libgrpc libgrpc++

PRODUCT_PACKAGES += civ_startup_notify civ_powerctl civ_applauncher

{{#build_example}}
PRODUCT_PACKAGES += grpc_greet_server_arg grpc_greet_client_arg
{{/build_example}}
