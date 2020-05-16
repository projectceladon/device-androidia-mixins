#!/usr/bin/env bash

if [ -z "$AIC_WORK_DIR" ]; then
    return
fi

pipe=$AIC_WORK_DIR/ipc/multiuserpipe
if [[ ! -p $pipe ]]; then
    return
fi

echo "$USER" >$pipe &

