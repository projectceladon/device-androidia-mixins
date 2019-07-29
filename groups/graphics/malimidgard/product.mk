OVERRIDE_RS_DRIVER := libRSDriverArm.so

PRODUCT_PACKAGES += \
					gralloc.$(TARGET_BOARD_PLATFORM) \
					hwcomposer.$(TARGET_BOARD_PLATFORM) \
					libGLES_mali \
					libbccArm \
					libmalicore \
					libRSDriverArm

