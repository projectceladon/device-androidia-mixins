
# Use GVB (Google Verify Boot)
$(call inherit-product,build/target/product/verity.mk)

{{#slot-ab}}
$(error Should enable AVB to support A/B slot)
{{/slot-ab}}

