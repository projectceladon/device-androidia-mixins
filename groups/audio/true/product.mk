$(call inherit-product,device/intel/cic/common/device.mk)
$(call inherit-product, device/intel/cic/common/houdini.mk)

PRODUCT_COPY_FILES += \
    device/intel/cic/cic_cloud/audio_policy_configuration.xml:system/vendor/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/vendor/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/vendor/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/vendor/etc/default_volume_tables.xml \

# Device modules
PRODUCT_PACKAGES += \
	android.hardware.audio@2.0-service

PRODUCT_PACKAGES += \
	android.hardware.audio@2.0-impl \
	android.hardware.audio@4.0-impl \
	android.hardware.audio.effect@2.0-impl \
	android.hardware.broadcastradio@1.0-impl \
	android.hardware.soundtrigger@2.0-impl

