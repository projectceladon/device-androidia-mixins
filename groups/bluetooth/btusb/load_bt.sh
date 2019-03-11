load_bt_modules() {
insmod $modules/kernel/crypto/ecdh_generic.ko
insmod $modules/kernel/net/bluetooth/bluetooth.ko
insmod $modules/kernel/drivers/bluetooth/btintel.ko
insmod $modules/kernel/drivers/bluetooth/btbcm.ko
insmod $modules/kernel/drivers/bluetooth/btrtl.ko
insmod $modules/kernel/drivers/bluetooth/btusb.ko
}
load_bt_modules&
