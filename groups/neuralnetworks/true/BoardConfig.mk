{{#mvm}}
ifeq ($(VM3), true)
{{/mvm}}

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/neuralnetworks

{{#mvm}}
endif
{{/mvm}}

