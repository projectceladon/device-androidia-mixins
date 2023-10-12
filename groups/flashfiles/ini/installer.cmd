flashing unlock
flash gpt gpt.bin
flash bootloader bootloader.img
erase teedata
erase misc
erase persistent
erase metadata
format userdata
format config
flash vbmeta_a vbmeta.img
flash vendor_boot_a vendor_boot.img
flash acpio_a acpio.img
flash boot_a boot.img
flash super super.img.part00 super.img.part01 
flashing lock
continue
