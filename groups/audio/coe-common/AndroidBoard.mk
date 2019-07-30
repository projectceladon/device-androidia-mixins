# Target specific audio files
include $(TARGET_DEVICE_DIR)/audio/AndroidBoard.mk

{{#modem}}
# MAMGR (Modem Audio Manager) for platform including one (and only one) XMM modem handling a single SIM
include $(INTEL_PATH_COMMON)/mamgr/xmm_single_modem_single_sim.mk
{{/modem}}
