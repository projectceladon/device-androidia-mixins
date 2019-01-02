# create primary storage symlink dynamically
PRODUCT_PACKAGES += set_storage
{{#treble}}
PRODUCT_PACKAGES += set_storage.vendor
{{/treble}}
