flashing unlock
flash gpt gpt.bin
erase misc
erase persistent
erase metadata
{{#config-partition}}
format config
{{/config-partition}}
{{^slot-ab}}
format cache
{{/slot-ab}}
format data
flash bootloader bootloader
{{^slot-ab}}
{{#avb}}
flash vbmeta vbmeta.img
{{/avb}}
flash boot boot.img
{{#tos_partition}}
flash tos tos.img
{{/tos_partition}}
flash recovery recovery.img
flash system system.img
{{#vendor-partition}}
flash vendor vendor.img
{{/vendor-partition}}
flash recovery recovery.img
{{/slot-ab}}
{{#slot-ab}}
{{#avb}}
flash vbmeta_a vbmeta.img
flash vbmeta_b vbmeta.img
{{/avb}}
flash boot_a boot.img
flash boot_b boot.img
{{#tos_partition}}
flash tos_a tos.img
flash tos_b tos.img
{{/tos_partition}}
flash system_a system.img
flash system_b system.img
{{#vendor-partition}}
flash vendor_a vendor.img
flash vendor_b vendor.img
{{/vendor-partition}}
{{/slot-ab}}
{{#factory-partition}}
flash factory factory.img
{{/factory-partition}}
{{#slot-ab}}
set_active a
{{/slot-ab}}
flashing lock
continue
