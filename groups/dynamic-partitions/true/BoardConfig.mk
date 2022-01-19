# Configure super partitions
BOARD_SUPER_PARTITION_GROUPS := group_sys
BOARD_GROUP_SYS_PARTITION_LIST := system{{#vendor-partition}} vendor{{/vendor-partition}}{{#product-partition}} product{{/product-partition}}{{#odm-partition}} odm{{/odm-partition}}

{{^dp_retrofit}}
BOARD_SUPER_PARTITION_SIZE := $(shell echo {{super_partition_size}}*1024*1024 | bc)
{{^slot-ab}}
BOARD_GROUP_SYS_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SIZE) - {{overhead_size}}*1024*1024" | bc)
{{/slot-ab}}
{{#slot-ab}}
{{^virtual_ab}}
BOARD_GROUP_SYS_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SIZE) / 2 - {{overhead_size}}*1024*1024" | bc)
{{/virtual_ab}}
{{#virtual_ab}}
BOARD_GROUP_SYS_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SIZE) - {{overhead_size}}*1024*1024" | bc)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/virtual_ab
{{/virtual_ab}}
{{/slot-ab}}
{{/dp_retrofit}}

{{#dp_retrofit}}
BOARD_SUPER_PARTITION_BLOCK_DEVICES := system{{#vendor-partition}} vendor{{/vendor-partition}}{{#product-partition}} product{{/product-partition}}{{#odm-partition}} odm{{/odm-partition}}
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE = $(SYSTEM_PARTITION_SIZE)
{{#vendor-partition}}
BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE = $(VENDOR_PARTITION_SIZE)
{{/vendor-partition}}
{{#product-partition}}
BOARD_SUPER_PARTITION_PRODUCT_DEVICE_SIZE = $(PRODUCT_PARTITION_SIZE)
{{/product-partition}}
{{#odm-partition}}
BOARD_SUPER_PARTITION_ODM_DEVICE_SIZE = $(ODM_PARTITION_SIZE)
{{/odm-partition}}
BOARD_SUPER_PARTITION_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) \
	{{#vendor-partition}}
	+ $(BOARD_SUPER_PARTITION_VENDOR_DEVICE_SIZE) \
	{{/vendor-partition}}
	{{#product-partition}}
	+ $(BOARD_SUPER_PARTITION_PRODUCT_DEVICE_SIZE) \
	{{/product-partition}}
	{{#odm-partition}}
	+ $(BOARD_SUPER_PARTITION_ODM_DEVICE_SIZE) \
	{{/odm-partition}}
	" | bc)
BOARD_GROUP_SYS_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SIZE) - {{overhead_size}}*1024*1024" | bc)
{{/dp_retrofit}}
