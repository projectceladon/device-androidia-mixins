# DPTF
{{#intel_modem}}
INTEL_MODEM_CTL := true
{{/intel_modem}}
PRODUCT_PACKAGES += esif_ufd \
    dsp.dv \
    dptf.dv \
    libc++_shared.so \
    Dptf \
    DptfPolicyActive \
    DptfPolicyAdaptivePerformance \
    DptfPolicyConditionalLogicLib \
    DptfPolicyCritical \
    DptfPolicyEmergencyCallMode \
    DptfPolicyPassive2 \
    DptfPolicyVirtualSensor \
    esif_ws \
    esif_cmp
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/dptf_{{platform}}.dv:/vendor/etc/dptf/dv/dptf.dv
{{#thermal_lite}}
PRODUCT_PACKAGES += thermal_lite
{{/thermal_lite}}

{{#ioc}}
IOC_ENABLED := true
THERMAL_HAL_IOC_TYPE += {{ioc}}
PRODUCT_PACKAGES += upe_ioc
{{/ioc}}
# Thermal Hal
PRODUCT_PACKAGES += thermal.$(TARGET_BOARD_PLATFORM) \
                    android.hardware.thermal@2.0-service.intel \
                    android.hardware.thermal@2.0-impl.intel
