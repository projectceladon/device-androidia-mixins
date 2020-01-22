KERNEL_APL_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/apl_nuc_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_APL_DIFFCONFIG)
KERNEL_caas_DIFFCONFIG = $(wildcard $(KERNEL_CONFIG_PATH)/caas_diffconfig)
KERNEL_DIFFCONFIG += $(KERNEL_caas_DIFFCONFIG)

# Specify /dev/mmcblk0 size here
BOARD_MMC_SIZE = 15335424K

BOARD_GPT_IMG = $(PRODUCT_OUT)/gpt.img
BOARD_FLASHFILES += $(BOARD_GPT_IMG):gpt.img

GPT_INI2IMG := ./$(INTEL_PATH_BUILD)/create_gpt_image.py

intermediate_img := $(call intermediates-dir-for,PACKAGING,flashfiles)/gpt.img

$(BOARD_GPT_IMG): $(BOARD_GPT_INI)
	$(hide) mkdir -p $(dir $(intermediate_img))
	$(hide) $(GPT_INI2IMG) --create --block $(BOARD_FLASH_BLOCK_SIZE) --table $< --size $(BOARD_MMC_SIZE) $(intermediate_img)
	$(hide) dd if=$(intermediate_img) of=$@ bs=$(BOARD_FLASH_BLOCK_SIZE) count=34
	$(hide) echo GEN $(notdir $@)
