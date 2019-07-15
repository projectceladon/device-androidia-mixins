=== Overview

This mixin group defines the overall Audio properties for a given platform such as Audio HALs (primary, SoundTrigger, Effects, Aware ...),
Configurable AudioPolicy, Debug Tools, PFW packages, MAMGR configurations, Treble Enable/Disable...

==== Options

--- autodetect
Autodetected Audio HW configuration.

--- bxt

Audio configurations for BXT platforms.

--- bxtp-mrb

Audio configurations for BXTP-MRB platforms.

--- bytcr-rt564x

Audio configurations for BYTCR platforms support Realtek rt564x codecs family.

--- bytcr-rt5651

Audio configurations for BYTCR platforms support Realtek rt5651 codec.

--- cht

Audio configurations for CHT Platforms (FFD, HR, CR and MRD).

--- coe-common

Audio common configurations.

--- gsd

Audio configurations for GoldSand platforms.

--- hdmi+usb

Audio configurations for HDMI and USB features.

--- kbl

Audio configurations for Kabylake platforms.

--- sofia_3gr

Audio configurations for Sofia 3G modems variants.

--- sofia_lte

Audio configurations for Sofia LTE modems variants.


	--- parameters
		- log: true or false - activate PFW verbose messages and Audio volume values
		- modem: true or false - modem support
		- wov: true or false - Wake On Voice feature support
		- aware: true or false - aware feature support
		- treble: true or false - use Audio HAL w/o hwbinder middleware

	--- code dir
		- $(TARGET_DEVICE_DIR)/audio/AndroidBoard.mk
		- device/intel/common/mamgr
		- $(TARGET_DEVICE_DIR)/audio/overlay
		- device/intel/sepolicy/audio/coe-common
		- vendor/intel/audio/probe/audio_correlation_tool
		- hardware/intel/audio/coe/soundtrigger
		- hardware/intel/audio/coe/aware
		- hardware/interfaces/audio
		- hardware/interfaces/soundtrigger
		- hardware/interfaces/broadcastradio
		- hardware/intel/audio/coe/primary
		- vendor/intel/audio/parameter-framework
		- vendor/intel/audio/parameter-framework-plugins
		- vendor/intel/audio/probe

--- none
No Audio support on platform

