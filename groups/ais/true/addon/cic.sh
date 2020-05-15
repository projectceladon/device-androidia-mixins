#!/bin/bash

function start_until_user_login {
local pipe=workdir/ipc/multiuserpipe

if [[ ! -p $pipe ]]; then
    mkfifo $pipe
    chmod 777 $pipe
fi

while true
do
    if read line <$pipe; then
        if [ -z "$line" ]; then
            break
        fi
        if [ "$CURRENT_USER" != "$line" ]; then
            echo "start AIC for user: $line"
            CURRENT_USER=$line
            /bin/bash aic start -u $line
        fi
    fi
done
}

if [ "$1" == "start" ] && [ -d "workdir/data-multi-user/data" ]; then
    start_until_user_login
else
/bin/bash aic $1
fi
