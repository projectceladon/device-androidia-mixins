SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/system_ext/public

{{#enable_msdk_omx}}
INTEL_STAGEFRIGHT := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
# Used for mediasdk_release only
USE_MEDIASDK := true
{{/enable_msdk_omx}}
