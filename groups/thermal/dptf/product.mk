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
    upe_ioc \
    esif_ws \
    esif_cmp
PRODUCT_COPY_FILES += $(LOCAL_PATH)/{{_extra_dir}}/dptf.dv:/vendor/etc/dptf/dv/dptf.dv
{{#thermal_lite}}
PRODUCT_PACKAGES += thermal_lite
{{/thermal_lite}}
# Thermal Hal
PRODUCT_PACKAGES += thermal.$(TARGET_BOARD_PLATFORM) \
                    android.hardware.thermal@1.0-service.gordon_peak \
                    android.hardware.thermal@1.0-impl.gordon_peak
