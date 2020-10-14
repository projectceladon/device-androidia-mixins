#! /bin/bash
QMP_SOCK=$1
TARGET=$2
SCRIPTS_DIR=$3
QMP_BIN=$SCRIPTS_DIR/wmi-qmp
ACPI_LISTENER_PID=
echo -E $QMP_SOCK $TARGET $SCRIPTS_DIR

if [ ! -f $QMP_BIN ]; then
    echo no $QMP_BIN;
    exit 1
fi

chmod +x $QMP_BIN
modprobe -r hp-wmi

exec acpi_listen | while IFS= read -r line;
do
line=$(echo "$line" | grep $TARGET)
if [ "$line" ]; then
    param1=$(echo $line | awk '{print $2}')
    param2=$(echo $line | awk '{print $3}')
    param1=$((16#$param1))
    param2=$((16#$param2))
    echo $TARGET $param1 $param2
    $QMP_BIN $QMP_SOCK "{ \"execute\": \"acpi-gpe-notify\", \"arguments\": { \"id\" : \"\\\_SB.WMIV\", \"val1\" : $param1, \"val2\" : $param2 } }"
fi
done
