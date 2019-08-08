#!/vendor/bin/sh

# enable the device mode
echo 1 > /sys/devices/pci0000:00/0000:00:15.1/intel-cht-otg.0/otg_id
# force a VBUS event
echo 1 > /sys/devices/pci0000:00/0000:00:15.1/intel-cht-otg.0/vbus_evt
