#!/system/bin/sh

function msg() {
  echo ">> $@"
}

function build() {
  local ai_tools="false"

  local help=$(
    cat <<EOF
Usage: $SELF build [-a <ai-tools>]
  Build LIC for celadon ivi

  -a <ai-tools>:      enable ai tools, default: $ai_tools 
  -h:                 print the usage message
EOF
  )

  while getopts 'ah' opt; do
    case $opt in
    a)
      ai_tools="true"
      ;;
    h)
      echo "$help" && exit
      ;;
    esac
  done

  echo "Build LIC:"
  echo "ai_tools=$ai_tools"

  uninstall

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

  if [ $ai_tools == "true" ]; then
    msg "building steam docker with Intel tensorflow extension for GPU"
    cat /vendor/etc/docker/weston-in-docker.tar | docker build - --network=host --build-arg SETUP_AI_TOOLS=true --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t steam
  else
    msg "build steam docker"
    cat /vendor/etc/docker/weston-in-docker.tar | docker build - --network=host --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t steam
  fi
  msg "Done!"
}

function install() {
  local backend="drm"
  local device="/dev/dri/renderD128"
  local size="1920x1080"

  local help=$(
    cat <<EOF
Usage: $SELF install [-b <backend>] [-c <container-id>] [-d <device>] [-s <size>]
  Install LIC for android ivi

  -b <backend>:       weston backend, default: $backend
  -d <device>:        gbm device for headless backend, default: $device
  -s <size>:          resolution of LIC in headless backend, default: $size
  -h:                 print the usage message
EOF
  )

  while getopts 'b:d:s:h' opt; do
    case $opt in
    b)
      backend=$OPTARG
      ;;
    d)
      device=$OPTARG
      ;;
    s)
      size=$OPTARG
      ;;
    h)
      echo "$help" && exit
      ;;
    esac
  done

  local width
  local height
  IFS="x" read width height <<<"$size"

  echo "Install LIC:"
  echo "backend=$backend"
  if [ $backend == "headless" ]; then
    echo "size=$size"
    echo "width=$width height=$height"
  fi

  if [[ ! -z "$(docker ps -a | tail -n +2 | awk '{print $NF}' | grep -w steam)" ]]; then
    msg "Delete existed steam container..."
    docker stop steam >/dev/null 2>&1
    docker rm steam >/dev/null 2>&1
    docker rmi steam >/dev/null 2>&1
  fi

  msg "create steam container with $backend backend..."

  if [ $backend == "drm" ]; then
    docker create -ti --privileged --network=host -e http_proxy=$http_proxy -e https_proxy=$https_proxy -v /dev/binder:/dev/binder -v /data/docker/sys/class/power_supply:/sys/class/power_supply -v /data/docker/config/99-ignore-mouse.rules:/etc/udev/rules.d/99-ignore-mouse.rules -v /data/docker/config/99-ignore-keyboard.rules:/etc/udev/rules.d/99-ignore-keyboard.rules -v /data/vendor/neuralnetworks/:/home/wid/.ipc/ -v /data/docker/steam:/home/wid/.steam --shm-size 8G --name steam steam
  elif [ $backend == "headless" ]; then
    rm -rf -v /data/docker/image/workdir/ipc
    mkdir -p -v /data/docker/image/workdir/ipc
    docker create -ti --privileged --network=host -e http_proxy=$http_proxy -e https_proxy=$https_proxy -e BACKEND=$backend -e CONTAINER_ID=0 -e DEVICE=$device -e K8S_ENV_DISPLAY_RESOLUTION_X=$width -e K8S_ENV_DISPLAY_RESOLUTION_Y=$height -v /dev/binder:/dev/binder -v /data/docker/sys/class/power_supply:/sys/class/power_supply -v /data/docker/config/99-ignore-mouse.rules:/etc/udev/rules.d/99-ignore-mouse.rules -v /data/docker/config/99-ignore-keyboard.rules:/etc/udev/rules.d/99-ignore-keyboard.rules -v /data/vendor/neuralnetworks/:/home/wid/.ipc/ -v /data/docker/steam:/home/wid/.steam -v /data/docker/image/workdir/ipc:/workdir/ipc --shm-size 8G --name steam steam
  fi
  msg "Done!"
}

function uninstall() {
  if [[ ! -z "$(docker ps -a | tail -n +2 | awk '{print $NF}' | grep -w steam)" ]]; then
    msg "Delete existed LIC container and image..."
    docker stop steam >/dev/null 2>&1
    docker rm steam >/dev/null 2>&1
    docker rmi steam >/dev/null 2>&1
  fi
}

function start() {
  docker start steam
}

function stop() {
  docker stop -t0 steam
}

function main() {
  local help=$(
    cat <<EOF
Usage: $self COMMAND [OPTIONS] [ARG...]
  Install and start LIC

Commands:
  build      build
  install    install
  uninstall  uninstall
  start      start
  stop       stop

Options:
  -h:        print the usage message

Build with proxy:
  export http_proxy=<http_proxy>
  export https_proxy=<https_proxy>
  lic_install.sh <command>

Run with no command:
  lic_install.sh equivalent to lic_install.sh build && lic_install.sh install

Run "$SELF COMMAND -h" for more information of a command
EOF
  )

  local cmd=$1
  if [[ -n $cmd ]]; then
    shift
  else
    build
    install
    exit 0
  fi

  case $cmd in
  build | install | uninstall | start | stop)
    $cmd $@
    ;;
  help | -h) echo "$help" && exit ;;
  *) echo "no such command: $cmd" && exit 1 ;;
  esac

}

main "$@"
