#!/bin/bash

work_dir=$PWD
caas_image=$work_dir/android.qcow2
usb_switch=$work_dir/auto_switch_pt_usb_vms.sh
find_port=$work_dir/findall.py

ovmf_file="./OVMF.fd"
[ ! -f $ovmf_file ] && ovmf_file="/usr/share/qemu/OVMF.fd"

GVTg_DEV_PATH="/sys/bus/pci/devices/0000:00:02.0"
GVTg_VGPU_UUID="4ec1ff92-81d7-11e9-aed4-5bf6a9a2bb0a"
function setup_vgpu(){
	res=0
	if [ ! -d $GVTg_DEV_PATH/$GVTg_VGPU_UUID ]; then
		echo "Creating VGPU..."
		sudo sh -c "echo $GVTg_VGPU_UUID > $GVTg_DEV_PATH/mdev_supported_types/i915-GVTg_V5_8/create"
		res=$?
	fi
	return $res
}

function create_snd_dummy(){
	modprobe snd-dummy
}
if [[ $1 == "--display-off" ]]
then
        display_type="none"
        ramfb_state="off"
        display_state="off"
else
        display_type="gtk,gl=on"
        ramfb_state="on"
        display_state="on"
fi

DP_OFF="false"
USB_ADB="false"
WIFI_PT="false"


for each in $@
do
	case $each in
		--display-off)
			DP_OFF="true"
			;;
		--usb-adb)
			USB_ADB="true"
			echo device > /sys/class/usb_role/intel_xhci_usb_sw-role-switch/role
			echo 0000:00:14.1 > /sys/bus/pci/devices/0000\:00\:14.1/driver/unbind
			modprobe vfio-pci
			echo 8086 9d30 > /sys/bus/pci/drivers/vfio-pci/new_id
			;;
		--wifi-passthrough)
			WIFI_PT="true"
			rfkill unblock all
			PCI_ID=`lspci -D -nn  | grep -oP '([\w:[\w.]+) Network controller' | awk '{print $1}'`
			echo $PCI_ID > /sys/bus/pci/devices/`echo $PCI_ID | sed 's/:/\\:/g'`/driver/unbind
			modprobe vfio-pci
			DEVICE_ID=`lspci -nn  | grep -oP 'Network controller.*\[\K[\w:]+'`
			echo $DEVICE_ID | sed 's/:/\ /g' > /sys/bus/pci/drivers/vfio-pci/new_id
			;;
	esac

	echo DP_OFF: $DP_OFF USB_ADB: $USB_ADB WIFI_PT: $WIFI_PT
done

smbios_serialno=$(dmidecode -t 2 | grep -i serial | awk '{print $3}')


common_options="\
 -m 2048 -smp 2 -M q35 \
 -name caas-vm \
 -enable-kvm \
 -vga none \
 -display $display_type \
 -k en-us \
 -machine kernel_irqchip=off \
 -global PIIX4_PM.disable_s3=1 -global PIIX4_PM.disable_s4=1 \
 -cpu host \
 -device qemu-xhci,id=xhci,addr=0x8 \
 `/bin/bash $usb_switch` \
 -device usb-host,vendorid=0x03eb,productid=0x8a6e \
 -device usb-host,vendorid=0x0eef,productid=0x7200 \
 -device usb-host,vendorid=0x222a,productid=0x0141 \
 -device usb-host,vendorid=0x222a,productid=0x0088 \
 -device usb-host,vendorid=0x8087,productid=0x0a2b \
 -device usb-mouse \
 -device usb-kbd \
 -drive file=$ovmf_file,format=raw,if=pflash \
 -chardev socket,id=charserial0,path=./kernel-console,server,nowait \
 -device isa-serial,chardev=charserial0,id=serial0 \
 -device intel-hda -device hda-duplex \
 -audiodev id=android_spk,timer-period=5000,server=$XDG_RUNTIME_DIR/pulse/native,driver=pa \
 -drive file=$caas_image,if=none,id=disk1 \
 -device virtio-blk-pci,drive=disk1,bootindex=1 \
 -device vhost-vsock-pci,id=vhost-vsock-pci0,guest-cid=3 \
 -device e1000,netdev=net0 \
 -netdev user,id=net0,hostfwd=tcp::5555-:5555,hostfwd=tcp::5554-:5554 \
 -device intel-iommu,device-iotlb=off,caching-mode=on \
 -full-screen \
 -fsdev local,security_model=none,id=fsdev0,path=./share_folder \
 -device virtio-9p-pci,fsdev=fsdev0,mount_tag=hostshare \
 -smbios "type=2,serial=$smbios_serialno"
 -nodefaults
"

function launch_hwrender(){

	VM_OPTIONS="-device vfio-pci-nohotplug,ramfb=$ramfb_state,sysfsdev=$GVTg_DEV_PATH/$GVTg_VGPU_UUID,display=$display_state,x-igd-opregion=on"
	if [ $DP_OFF = "true" ]
	then
		VM_OPTIONS="$VM_OPTIONS -pidfile android_vm.pid"
	fi
	if [ $USB_ADB = "true" ]
	then
		VM_OPTIONS="$VM_OPTIONS -device vfio-pci,host=00:14.1,id=dwc3,addr=0x14,x-no-kvm-intx=on"
	fi
	if [ $WIFI_PT = "true" ]
	then
		 VM_OPTIONS="$VM_OPTIONS -device vfio-pci,host=`lspci -nn  | grep -oP '([\w:[\w.]+) Network controller' | awk '{print $1}'`"
	fi
	if [ $DP_OFF = "true" ]
	then
		VM_OPTIONS="$VM_OPTIONS $common_options &"
	else
		VM_OPTIONS="$VM_OPTIONS $common_options"
	fi


	qemu-system-x86_64 $VM_OPTIONS

	sleep 5
	echo -n "Android started successfully and is running in background, pid of the process is:"
	if [ $DP_OFF = "true" ]
	then
		cat android_vm.pid
	fi
}

function launch_swrender(){
	if [[ $1 == "--display-off" ]]
        then
		qemu-system-x86_64 \
		-device qxl-vga,xres=1280,yres=720 \
		-pidfile android_vm.pid \
		$common_options &
		sleep 5
		echo -n "Android started successfully and is running in background, pid of the process is:"
		cat android_vm.pid
		echo -ne '\n'
	else
		qemu-system-x86_64 \
		-device qxl-vga,xres=1280,yres=720 \
		$common_options
	fi
}

function check_nested_vt(){
	nested=$(cat /sys/module/kvm_intel/parameters/nested)
	if [[ $nested != 1 && $nested != 'Y' ]]; then
		echo "E: Nested VT is not enabled!"
		exit -1
	fi
}

version=`cat /proc/version`

vno=$(echo $version | \
	awk '{
		for(i=0;i<NF;i++) { if ($i == "Linux" && $(i+1) == "version") { print $(i+2); next; } }
	}'
)
if [[ "$vno" > "5.0.0" ]]; then
	check_nested_vt
	create_snd_dummy
	setup_vgpu
	if [[ $? == 0 ]]; then
		launch_hwrender $1
	else
		echo "W: Failed to create vgpu, fall to software rendering"
		launch_swrender $1
	fi
else
	echo "E: Detected linux version $vno"
	echo "E: Please upgrade kernel version newer than 5.0.0!"
	exit -1
fi

