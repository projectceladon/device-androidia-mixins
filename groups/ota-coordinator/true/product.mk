PRODUCT_PACKAGES += \
	ota_coordinator \
	ota_coordinator_recovery


PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.ota_coordinator.last_slot_suffix=_a \
	vendor.ota_coordinator.factory_reset=false \

