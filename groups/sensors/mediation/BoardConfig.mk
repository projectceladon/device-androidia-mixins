USE_SENSOR_MEDIATION_HAL := true

{{#disable_static_sensor_list}}
MEDIATION_HAL_DISABLE_STATIC_SENSOR_LIST := true
{{/disable_static_sensor_list}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/sensors/mediation
