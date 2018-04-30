{{#mediasdk}}
{{#media_sdk_source}}
BOARD_HAVE_MEDIASDK_SRC := true
{{/media_sdk_source}}

# Enable Media Sdk
BUILD_WITH_FULL_STAGEFRIGHT := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
USE_MEDIASDK := true
{{/mediasdk}}
