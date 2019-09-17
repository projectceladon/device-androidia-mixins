#!/system/bin/sh

customize_script="/data/local/tmp/customize_script.sh"
if [ -f ${customize_script} ];
then
	${customize_script}
fi
