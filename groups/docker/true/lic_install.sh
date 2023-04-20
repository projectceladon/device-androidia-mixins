#!/system/bin/sh

function msg() {
    echo ">> $@"
}

if [[ ! -z "$http_proxy" ]]; then
    msg "restart dockerd under proxy environment..."
    killall dockerd
    while [[ ! -z "$(ps -A | awk '{print $NF}' | grep -w dockerd)" ]]; do
        msg "wait for dockerd to terminated..."
        sleep 1
    done
    dockerd --iptables=false &
    sleep 20
fi

if [[ ! -z "$(docker ps -a | tail -n +2 | awk '{print $NF}' | grep -w steam)" ]]; then
    msg "Delete existed steam container..."
    docker stop steam > /dev/null 2>&1
    docker rm steam > /dev/null 2>&1
    docker rmi steam > /dev/null 2>&1
fi

if [ $# -gt 0 ]; then
    if [ $1=="ai-tools" ]; then
        msg "building steam docker with Intel tensorflow extension for GPU"
        cat /vendor/etc/docker/weston-in-docker.tar | docker build - --network=host --build-arg SETUP_AI_TOOLS=true --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t steam
    else
        msg "invalid argument, please pass ai-tools to install intel extension for tensorflow.."
        return -1
    fi
else
    msg "build steam docker"
    cat /vendor/etc/docker/weston-in-docker.tar | docker build - --network=host --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t steam
fi

msg "create steam container..."
docker create -ti --privileged --network=host -e http_proxy=$http_proxy -e https_proxy=$https_proxy -v /dev/binder:/dev/binder -v /data/docker/sys/class/power_supply:/sys/class/power_supply -v /data/docker/config/99-ignore-mouse.rules:/etc/udev/rules.d/99-ignore-mouse.rules -v /data/docker/config/99-ignore-keyboard.rules:/etc/udev/rules.d/99-ignore-keyboard.rules -v /data/vendor/neuralnetworks/:/home/wid/.ipc/ -v /data/docker/steam:/home/wid/.steam --shm-size 8G --name steam steam
msg "Done!"
