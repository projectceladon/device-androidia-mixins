//ACPI module device to config First-Stage Mount
DefinitionBlock ("firststage-mount.aml", "SSDT", 1, "INTEL ", "android", 0x00001000)
{
Scope (\)
{
External (\_SB.CFG0, DeviceObj)
Scope(_SB)
{
        Device (ANDT)
        {
            Name (_HID, "ANDR0001")
            Name (_STR, Unicode("android device tree"))  // Optional

            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"android.compatible", "android,firmware"},
                    Package () {"android.vbmeta.compatible","android,vbmeta"},
                    Package () {"android.vbmeta.parts","vbmeta,boot,system,vendor{{#avb}}{{^slot-ab}},recovery{{/slot-ab}}{{/avb}}{{#trusty}},tos{{/trusty}}{{#product-partition}},product{{/product-partition}}"},
                    Package () {"android.fstab.compatible", "android,fstab"},
                    Package () {"android.fstab.vendor.compatible", "android,vendor"},
                    Package () {"android.fstab.vendor.dev", "/dev/block/pci/pci0000:00/0000:00:{{diskbus}}/by-name/vendor"},  // Varies with platform
                    Package () {"android.fstab.vendor.type", "ext4"},  // May vary with platform
                    Package () {"android.fstab.vendor.mnt_flags", "ro"},  // May vary with platform
                    Package () {"android.fstab.vendor.fsmgr_flags", "wait{{#slot-ab}},slotselect{{/slot-ab}}{{#avb}},avb{{/avb}}"},  // May vary with platform
{{#product-partition}}
                    Package () {"android.fstab.product.compatible", "android,product"},
                    Package () {"android.fstab.product.dev", "/dev/block/pci/pci0000:00/0000:00:{{diskbus}}/by-name/product"},  // Varies with platform
                    Package () {"android.fstab.product.type", "ext4"},  // May vary with platform
                    Package () {"android.fstab.product.mnt_flags", "ro"},  // May vary with platform
                    Package () {"android.fstab.product.fsmgr_flags", "wait{{#slot-ab}},slotselect{{/slot-ab}}{{#avb}},avb{{/avb}}"},  // May vary with platform
{{/product-partition}}
{{^avb}}
                    Package () {"android.fstab.system.compatible", "android,system"},
                    Package () {"android.fstab.system.dev", "/dev/block/pci/pci0000:00/0000:00:{{diskbus}}/by-name/system"},  // Varies with platform
                    Package () {"android.fstab.system.type", "ext4"},  // May vary with platform
                    Package () {"android.fstab.system.mnt_flags", "ro"},  // May vary with platform
                    Package () {"android.fstab.system.fsmgr_flags", "wait"},  // May vary with platform
{{/avb}}
{{#avb}}
{{^slot-ab}}
                    Package () {"android.fstab.system.compatible", "android,system"},
                    Package () {"android.fstab.system.dev", "/dev/block/pci/pci0000:00/0000:00:{{diskbus}}/by-name/system"},  // Varies with platform
                    Package () {"android.fstab.system.type", "ext4"},  // May vary with platform
                    Package () {"android.fstab.system.mnt_flags", "ro"},  // May vary with platform
                    Package () {"android.fstab.system.fsmgr_flags", "wait,avb"},  // May vary with platform
{{/slot-ab}}
{{/avb}}
{{^slot-ab}}
                    Package () {"android.fstab.config.compatible", "android,config"},
                    Package () {"android.fstab.config.dev", "/dev/block/pci/pci0000:00/0000:00:{{diskbus}}/by-name/config"},  // Varies with platform
                    Package () {"android.fstab.config.type", "ext4"},  // May vary with platform
                    Package () {"android.fstab.config.mnt_flags", "rw"},  // May vary with platform
                    Package () {"android.fstab.config.fsmgr_flags", "wait,check"},  // May vary with platform
{{/slot-ab}}
                }
            })
        }
}
}
}
