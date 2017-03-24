{{#record_size}}
BOARD_KERNEL_CMDLINE += \
	intel_pstore_pram.record_size={{{record_size}}}
{{/record_size}}

{{#console_size}}
BOARD_KERNEL_CMDLINE += \
	intel_pstore_pram.console_size={{{console_size}}}
{{/console_size}}

{{#ftrace_size}}
BOARD_KERNEL_CMDLINE += \
	intel_pstore_pram.ftrace_size={{{ftrace_size}}}
{{/ftrace_size}}

{{#dump_oops}}
BOARD_KERNEL_CMDLINE += \
	intel_pstore_pram.dump_oops={{{dump_oops}}}
{{/dump_oops}}

{{#ecc}}
BOARD_KERNEL_CMDLINE += \
	intel_pstore_pram.ecc={{{ecc}}}
{{/ecc}}

PSTORE_CONFIG := PRAM
