TARGET_USE_ACRN := true
ACRN_CMDLINE := {{acrn_cmdline}}
MB2_PARTS := {{mb2_parts}}
BOARD_ACRNIMAGE_PARTITION_SIZE := $$(({{partition_size}} * 1024 *1024))

{{^slot-ab}}
{{/slot-ab}}
{{#slot-ab}}
AB_OTA_PARTITIONS += acrn
{{/slot-ab}}
