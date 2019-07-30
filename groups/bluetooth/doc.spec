=== Overview

Loading Bluetooth Driver.

--- deps

    - sepolicy
    - wifi


==== Options

--- marvellW8897

marvellW8897 is used to initialize the marvell driver, also configure the bluetooth hci settings.

    --- parameters
        - btcfg : Used to configure bluetooth firmware to operate on 115200 speed for data/control communication.
        - hwcfg : Depending on the hardware, this should trigger operation to create or configure the hci device (hciattach...) in device init rules.
        - btscocfg : Used to put bluetooth as master during hfp.

    --- code dir
        - device/intel/mixins/groups/bluetooth/marvellW8897
        - device/intel/sepolicy/bluetooth/marvellW8897
        - device/intel/sepolicy/bluetooth/common/
        - device/intel/common/bluetooth/
        - system/bt/
        - vendor/intel/hardware/interfaces/bluetooth/
        - kernel/bxt/drivers/bluetooth/
        - vendor/intel/fw/marvell
