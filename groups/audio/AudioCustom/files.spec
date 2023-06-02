[mapping]
default: audio/default
PCH-ALC283: audio/PCH-ALC283
PCH-CX20724: audio/PCH-CX20724
reference_configurable_audio_policy: audio/reference_configurable_audio_policy
common/AndroidBoard.mk: audio/AndroidBoard.mk

[devicefiles]
default: 
PCH-ALC283: 
PCH-CX20724: 
reference_configurable_audio_policy:
common/AndroidBoard.mk:

[extrafiles]
audio_policy_criteria.conf: "configurable audio policy criteria file"
audio_policy_engine_product_strategies.xml: "audio product strategy file"
audio_policy_engine_configuration.xml: "audio policy engine configuration"
audio_policy_engine_criteria.xml: "audio policy engine criteria"
audio_policy_engine_criterion_types.xml.in: "audio policy engine criteria types"
auto_hal.in : "auto script"
