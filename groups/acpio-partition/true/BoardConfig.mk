TARGET_USE_ACPIO := true
BOARD_ACPIOIMAGE_PARTITION_SIZE := $$(({{partition_size}} * 1024 *1024))

{{^slot-ab}}
BOARD_RECOVERY_ACPIO = $(ACPIO_BIN)
BOARD_INCLUDE_RECOVERY_ACPIO := true
{{/slot-ab}}
{{#slot-ab}}
AB_OTA_PARTITIONS += acpio
{{/slot-ab}}
