[mixinfo]
# fstab is using shortcut /dev/block/by-name that is created by
# disk-bus mixin.
deps = disk-bus

[defaults]
acpi_permissive = false
bios_variant = release
blpolicy_use_efi_var = true
bootloader_block_size = 512
bootloader_len = 33
bootloader_policy = false
data_encryption = true
data_use_f2fs = false
disable_watchdog = false
disk_encryption = true
file_encryption = false
flash_block_size = 512
hung_task_timeout_secs = 120
ifwi_debug = false
ignore_not_applicable_reset = false
ignore_rsci = false
keybox_provision = false
magic_key_timeout = false
os_secure_boot = false
rpmb = false
rpmb_simulate = false
run_tco_on_shutdown = false
self_usb_device_mode_protocol = false
system_partition_size = 2560
target =
txe_bind_root_of_trust = false
uefi_arch = x86_64
usb_storage = false
use_charging_applet = false
use_power_button = false
verity_mode = true
verity_warning = true
watchdog_parameters = false
