#!/vendor/bin/sh

wait_timer=0
KF_UPDATE_FILE="/postinstall/firmware/kernelflinger.efi"
BIOS_UPDATE_FILE="/postinstall/firmware/BIOSUPDATE.fv"

if [[ -f ${KF_UPDATE_FILE} && -f ${BIOS_UPDATE_FILE} ]]; then
    setprop vendor.ota.update.fw kf_and_bios
    wait_timer=1
else 
    if [ -f ${KF_UPDATE_FILE} ]; then
        setprop vendor.ota.update.fw kf
        wait_timer=1
    fi
    if [ -f ${BIOS_UPDATE_FILE} ]; then
        setprop vendor.ota.update.fw bios
        wait_timer=1
    fi
fi

if [ ${wait_timer} != 0 ]; then
    while [ ${wait_timer} -le 30 ];
    do
        UPDATE_STATUS=$(getprop vendor.ota.update.fw)
        if [ "$UPDATE_STATUS" = "done" ]; then
            break;
        fi
        let wait_timer=wait_timer+1
        sleep 1
    done
fi
exit
