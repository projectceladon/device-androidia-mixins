PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/car_core_hardware.xml:vendor/etc/permissions/car_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:vendor/etc/permissions/android.hardware.type.automotive.xml \
    frameworks/native/data/etc/android.hardware.screen.landscape.xml:vendor/etc/permissions/android.hardware.screen.landscape.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:vendor/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.software.activities_on_secondary_displays.xml:vendor/etc/permissions/android.software.activities_on_secondary_displays.xml \
    $(INTEL_PATH_COMMON)/framework/android.software.cant_save_state.xml:vendor/etc/permissions/android.software.cant_save_state.xml

# Make sure vendor car product overlays take precedence than google definition
# under packages/services/Car/car_product/overlay/
PRODUCT_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/device-type/overlay-car
$(call inherit-product, packages/services/Car/car_product/build/car.mk)

PRODUCT_PACKAGES += \
    CarSettings \
    VmsPublisherClientSample \
    VmsSubscriberClientSample \

{{^aosp_hal}}
PRODUCT_PACKAGES += android.hardware.automotive.vehicle.intel@2.0-service
{{/aosp_hal}}

PRODUCT_PACKAGES += android.hardware.automotive.audiocontrol@1.0-service.intel

{{#aosp_hal}}
PRODUCT_PACKAGES += android.hardware.automotive.vehicle@V1-default-service \
    android.hardware.automotive.vehicle@V1-default-impl
{{/aosp_hal}}

VEHICLE_HAL_PROTO_TYPE := {{vhal-proto-type}}
{{#ioc}}
# IOC is enabled, add slcan or cbc proto in VHAL
VEHICLE_HAL_PROTO_TYPE += {{ioc}}
{{/ioc}}

PRODUCT_PROPERTY_OVERRIDES += telephony.active_modems.max_count=2
