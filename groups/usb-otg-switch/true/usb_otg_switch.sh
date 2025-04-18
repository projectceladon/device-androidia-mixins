#!/vendor/bin/sh

KERNEL_VERSION=$(uname -r)

echo $1
if [[ $1 = "h" ]]; then
  case "$KERNEL_VERSION" in
    4.4*) echo h > /sys/bus/platform/devices/intel-cht-otg.0/mux_state ;;
    4.9*) echo h > /sys/bus/platform/drivers/intel_usb_dr_phy/intel_usb_dr_phy.0/mux_state ;;
    *) for role in `ls /sys/bus/platform/devices/intel_xhci_usb_sw*/port`; do echo $2 > $role; done
     for role in `ls /sys/class/usb_role/intel_xhci_usb_sw*-role-switch/role`; do echo host > $role; done;;
  esac

elif [[ $1 = "p" ]]; then
  case "$KERNEL_VERSION" in
    4.4*) echo p > /sys/bus/platform/devices/intel-cht-otg.0/mux_state ;;
    4.9*) echo p > /sys/bus/platform/drivers/intel_usb_dr_phy/intel_usb_dr_phy.0/mux_state ;;
    *) for role in `ls /sys/bus/platform/devices/intel_xhci_usb_sw*/port`; do echo $2 > $role; done
     for role in `ls /sys/class/usb_role/intel_xhci_usb_sw*-role-switch/role`; do echo device > $role; done;;
  esac

else
  echo "Please input h to swith to USB OTG mode"
  echo "usb_otg_switch.sh h <port>"
  echo "Please input p to swith USB device mode"
  echo "usb_otg_switch.sh p <port>"
fi
