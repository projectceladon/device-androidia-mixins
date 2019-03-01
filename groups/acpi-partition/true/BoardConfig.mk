TARGET_USE_ACPI := true
BOARD_ACPIIMAGE_PARTITION_SIZE := $$(({{partition_size}} * 1024 *1024))
{{#slot-ab}}
AB_OTA_PARTITIONS += acpi
{{/slot-ab}}
