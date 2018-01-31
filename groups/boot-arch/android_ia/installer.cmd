flashing unlock
flash gpt gpt.bin
erase misc
erase persistent
erase metadata
{{#config-partition}}
format config
{{/config-partition}}
format cache
format data
flash bootloader bootloader
flash boot boot.img
{{#tos_partition}}
flash tos tos.img
{{/tos_partition}}
flash recovery recovery.img
flash system system.img
{{#vendor-partition}}
flash vendor vendor.img
{{/vendor-partition}}
{{#factory-partition}}
flash factory factory.img
{{/factory-partition}}
flashing lock
continue
