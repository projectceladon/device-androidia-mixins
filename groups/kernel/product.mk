{{#modules_in_bootimg}}
  KERNEL_MODULES_ROOT_PATH := lib/modules
  KERNEL_MODULES_ROOT := root/$(KERNEL_MODULES_ROOT_PATH)
{{/modules_in_bootimg}}

KERNEL_MODULES_ROOT_PATH ?= vendor/lib/modules
KERNEL_MODULES_ROOT ?= $(KERNEL_MODULES_ROOT_PATH)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.vendor.boot.moduleslocation=/$(KERNEL_MODULES_ROOT_PATH)
