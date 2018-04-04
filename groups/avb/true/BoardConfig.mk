BOARD_AVB_ENABLE := true

KERNELFLINGER_AVB_CMDLINE := true

BOARD_VBMETAIMAGE_PARTITION_SIZE := 2097152
BOARD_FLASHFILES += $(PRODUCT_OUT)/vbmeta.img

# Now use AVB to support A/B slot
PRODUCT_STATIC_BOOT_CONTROL_HAL := bootctrl.avb libavb_user

{{#slot-ab}}
AB_OTA_PARTITIONS += vbmeta
{{/slot-ab}}
