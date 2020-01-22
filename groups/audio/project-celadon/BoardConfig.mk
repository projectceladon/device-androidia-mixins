#BOARD_USES_ALSA_AUDIO := true
#BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_GENERIC_AUDIO ?= false
# USE_CUSTOM_PARAMETER_FRAMEWORK := true
ifneq ($(BOARD_USES_GENERIC_AUDIO), true)
# Audio HAL selection Flag default setting.
#  INTEL_AUDIO_HAL:= audio     -> baseline HAL
#  INTEL_AUDIO_HAL:= audio_pfw -> PFW-based HAL
INTEL_AUDIO_HAL := audio_pfw
else
INTEL_AUDIO_HAL := stub
endif

DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/audio/overlay

#Enable SOF
SOF_AUDIO := false

{{#audio_hal}}
# Enable configurable audio policy
USE_CONFIGURABLE_AUDIO_POLICY := 1
{{/audio_hal}}

{{^audio_hal}}
# Disable configurable audio policy
USE_CONFIGURABLE_AUDIO_POLICY := 0
{{/audio_hal}}

# # Use XML audio policy configuration file
USE_XML_AUDIO_POLICY_CONF := 1

# # Use Intel's custom PFW
USE_CUSTOM_PARAMETER_FRAMEWORK := true

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/audio/coe-common

{{#treble}}
# # Do not use audio HAL directly w/o hwbinder middleware
USE_LEGACY_LOCAL_AUDIO_HAL := false
{{/treble}}
{{^treble}}
# # Use audio HAL directly w/o hwbinder middleware
USE_LEGACY_LOCAL_AUDIO_HAL := true
{{/treble}}

