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
    DptfPolicyPassive \
    DptfPolicyVirtualSensor \
    upe_java \
    jhs
PRODUCT_COPY_FILES += $(LOCAL_PATH)/dptf.dv:/system/etc/dptf/dv/dptf.dv
