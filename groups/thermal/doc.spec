=== Overview

Thermal is used to configure different TM (thermal management) service

--- deps

    -  sepolicy


==== Options

--- none

This option will disable TM service.

--- dptf

This option will enable DPTF running as the TM service.

    --- parameters
        - intel_modem: config whether enable modem thermal-throttling
        - thermal-lite: config whether enable thermal-lite service

    --- code dir
        - vendor/intel/dptf/
        - device/intel/sepolicy/thermal/
        - device/intel/sepolicy/thermal/dptf

--- itux

This option will enable itux running as the TM service.

    --- parameters
        - modem_zone: config whether enable modem thermal-throttling
        - thermal-lite: config whether enable thermal-lite service
        - change_vbus_det_type: configure VBUS decttion type during thermal shutdown

    --- code dir
        - hardware/intel/common/utils/itux
        - vendor/intel/apps/itux
        - device/intel/sepolicy/thermal/
        - device/intel/sepolicy/thermal/itux

--- ituxd

This option will enable ituxd running as the TM service.

--- daemon

This option will enable thermal-daemon running as the TM service.

--- hal
This option will enable thermal hal.

    --- code dir
        - vendor/intel/hardware/interfaces/thermal
        - hardware/intel/thermal
        - device/intel/sepolicy/thermal/
        - device/intel/sepolicy/thermal/hal
