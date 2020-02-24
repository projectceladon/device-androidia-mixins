#!/bin/bash
sleep 4
echo "adb setup"
adb kill-server
adb wait-for-device devices
adb wait-for-device root
adb shell "echo dwc3.1.auto > /config/usb_gadget/g1/UDC"
adb shell "setprop sys.usb.controller dwc3.1.auto"
echo "done"
