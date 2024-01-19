[mapping]
{{ref_target}}.mk: {{target}}.mk

[devicefiles]
bldr_utils.img: "fastboot image is used when bldr partsize is 0"
compatibility_matrix.xml: "add compatibility for ota verify"
manifest.xml: "define hidl interface"
framework_manifest.xml: "define hidl framework interface"
overlay: "configurations for SystemUI"
system.prop: "system properties file"
{{ref_target}}.mk: "product definition file"
r2_{{target}}.mk: "Ring 2 target for P.car"
README_cvmb: "README file for host scripts"
