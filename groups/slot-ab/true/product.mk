

# Currently the update_verifier does not support AVB and A/B slot, so do not include it if enable AVB and A/B slot.
# Will enable it after the update_verifier updated.
#PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_verifier
