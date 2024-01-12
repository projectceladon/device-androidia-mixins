PRODUCT_PACKAGES_DEBUG += \
    AndroidTerm \
    libjackpal-androidterm4 \
    peeknpoke \
    pytimechart-record \
    lspci \
    llvm-symbolizer

ifeq ($(MIXIN_DEBUG_LOGS),true)
{{#logcat2hvc}}
PRODUCT_PACKAGES_DEBUG += \
    logcat2hvc
{{/logcat2hvc}}
endif
