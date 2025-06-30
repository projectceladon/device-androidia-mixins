USE_SENSOR_MEDIATION_HAL := true

{{#disable_static_sensor_list}}
MEDIATION_HAL_DISABLE_STATIC_SENSOR_LIST := true
{{/disable_static_sensor_list}}

SOONG_CONFIG_NAMESPACES += senPlugin
SOONG_CONFIG_senPlugin  += SENSOR_LIST
SOONG_CONFIG_senPlugin_SENSOR_LIST := {{enable_sensor_list}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/sensors/mediation
