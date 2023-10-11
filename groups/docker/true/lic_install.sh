#!/system/bin/sh

CORECONTAINERS="gamecore aicore"
COREIMAGES="gamecore aicore"

function msg() {
  echo ">> $@"
}

function start_container() {
  for i in $*
  do
    if [[ ! -z "$(docker ps -a | tail -n +2 | awk '{print $NF}' | grep $i)" ]]; then
      msg "Start $i container..."
      ci=$(docker ps -a | awk '$NF~/^'$i'*/ {print $NF}')
      docker start $ci
    fi
  done
}

function stop_container() {
  for i in $*
  do
    if [[ ! -z "$(docker ps | tail -n +2 | awk '{print $NF}' | grep $i)" ]]; then
      msg "Stop $i container..."
      docker stop -t0 $(docker ps -a | awk '$NF~/^'$i'*/ {print $NF}')
    fi
  done
}

function cleanup_container() {
  for i in $*
  do
    if [[ ! -z "$(docker ps -a | tail -n +2 | awk '{print $NF}' | grep $i)" ]]; then
      msg "Stop and rm existed $i container..."
      docker stop -t0 $(docker ps -a | awk '$NF~/^'$i'*/ {print $NF}')
      docker rm -f $(docker ps -a | awk '$NF~/^'$i'*/ {print $NF}')
    fi
  done
}

function cleanup_image() {
  for i in $*
  do
    if [[ ! -z "$(docker images | tail -n +2 | awk '{print $1}' | grep $i)" ]]; then
      msg "Remove image $i ..."
      docker rmi $(docker image list | awk '$1~/^'$i'*/ {print $1}')
    fi
  done
}

function build() {
  local ai_build="false"
  local full_ai_build="false"
  local magic=intel
  local mesa="true"

  local help=$(
    cat <<EOF
Usage: $SELF build [-a <ai-tools>]
  Build LIC for celadon ivi

  -a <ai-build>:      enable ai build, default: $ai_build
  -A <full_ai-build>: enable full ai build, default: $full_ai_build
  -m <magic>:         Magic. Default: $magic
  -M <mesa>:          Mesa. Default: $mesa
  -h:                 print the usage message
EOF
  )

  while getopts 'aAm:M:h' opt; do
    case $opt in
    a)
      ai_build="true"
      ;;
    A)
      ai_build="true"
      full_ai_build="true"
      ;;
    m)
      magic=$OPTARG
      ;;
    M)
      mesa=$OPTARG
      ;;
    h)
      echo "$help" && exit
      ;;
    esac
  done

  echo "Build LIC:"
  echo "ai_build=$ai_build"
  echo "full_ai_build=$full_ai_build"
  echo "magic=$magic"

  uninstall

  if [[ ! -z "$http_proxy" ]]; then
    msg "restart dockerd under proxy environment..."
    killall dockerd-dev
    while [[ ! -z "$(ps -A | awk '{print $NF}' | grep -w dockerd)" ]]; do
      msg "wait for dockerd to terminated..."
      sleep 1
    done
    dockerd --iptables=false &
    sleep 20
  fi

  msg "build gamecore docker"
  cat /vendor/etc/docker/gamecore.tar | docker build - --network=host --build-arg MAGIC=$magic --build-arg MESA=$mesa --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t liccore --target liccore
  cat /vendor/etc/docker/gamecore.tar | docker build - --network=host --build-arg MAGIC=$magic --build-arg MESA=$mesa --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t gamecore

  if [ $ai_build == "true" ]; then
    msg "building aicore container with Intel tensorflow extension for GPU"
    if [ $full_ai_build == "true" ]; then
      ai_opts="--build-arg SETUP_AI_TOOLS=true"
    fi
    cat /vendor/etc/docker/aicore.tar | docker build - --network=host $ai_opts --build-arg MAGIC=$magic --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy --build-arg no_proxy=localhost -t aicore
  fi

  msg "Done!"
}

function install() {
  local ai_build="false"
  local backend="drm"
  local device="/dev/dri/renderD128"
  local size="1920x1080"
  local privileged="false"
  local mem_total=$(expr $(cat /proc/meminfo | grep MemTotal | awk '{print $2}') / 1024 / 1024)
  memory_size=${mem_total}g

  local lic_device=$(getprop persist.vendor.lic.device)
  if [ -n "$lic_device" ] && [ -c $lic_device ]; then
    device=$lic_device
  elif [ -c /dev/dri/renderD129 ]; then
    device="/dev/dri/renderD129"
  fi

  if [ "$device" = "/dev/dri/renderD129" ]; then 
    vendor_id=$(cat /sys/class/drm/renderD129/device/uevent | grep "PCI_ID" | awk -F'=' '{print $2}' | awk -F':' '{print $1}')
    if [ "$vendor_id" = "1AF4" ]; then
      device="/dev/dri/renderD128"
    fi
  fi

  setprop persist.vendor.lic.device $device

  if [[ ! -z "$(docker images | tail -n +2 | awk '{print $1}' | grep aicore)" ]]; then
    ai_build="true"
  fi

  local help=$(
    cat <<EOF
Usage: $SELF install [-b <backend>] [-s <size>] [-p] [m <memory_size>]
  Install LIC for android ivi

  -b <backend>:       weston backend, default: $backend
  -s <size>:          resolution of LIC in headless backend, default: $size
  -p:                 create container with privileged mode
  -m <memory_size>    Memory size(a positive integer, followed by a suffix of b, k, m, g, to indicate bytes, kilobytes, megabytes, or gigabytes). Maximum and default: $memory_size
  -h:                 print the usage message
EOF
  )

  while getopts 'b:d:s:hpn:m:' opt; do
    case $opt in
    b)
      backend=$OPTARG
      ;;
    s)
      size=$OPTARG
      ;;
    p)
      privileged="true"
      ;;
    m)
      memory_size=$OPTARG
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
  echo "backend = $backend"
  echo "memory_size = $memory_size"
  if [ $backend == "headless" ]; then
    echo "size = $size"
    echo "width = $width height = $height"
    echo "privileged = $privileged"
    echo "device = $device"
  fi

  cleanup_container $CORECONTAINERS

  msg "create gamecore container with $backend backend..."
  create_opts="-ti --network=host -e http_proxy=$http_proxy -e https_proxy=$https_proxy -v /dev/binder:/dev/binder -v /data/vendor/docker/sys/class/power_supply:/sys/class/power_supply -v /data/vendor/docker/config/99-ignore-mouse.rules:/etc/udev/rules.d/99-ignore-mouse.rules -v /data/vendor/docker/config/99-ignore-keyboard.rules:/etc/udev/rules.d/99-ignore-keyboard.rules --shm-size 8G --memory=$memory_size"
  if [ $backend == "drm" ]; then
    create_opts="$create_opts --privileged --user root -v /data/vendor/docker/steam:/home/wid/.steam -v /data/vendor/docker/xdg_config:/home/wid/xdg_config -v /data/vendor/docker/Games:/home/wid/Games --name gamecore --hostname gamecore"
    docker create $create_opts gamecore
  elif [ $backend == "headless" ]; then
    rm -rf -v /data/vendor/docker/image/workdir/ipc
    mkdir -p -v /data/vendor/docker/image/workdir/ipc
    create_opts="$create_opts -e BACKEND=$backend -e DEVICE=$device -e K8S_ENV_DISPLAY_RESOLUTION_X=$width -e K8S_ENV_DISPLAY_RESOLUTION_Y=$height -e HEADLESS=true -v /data/vendor/docker/image/workdir/ipc:/workdir/ipc --ulimit nofile=524288:524288"
    create_opts="$create_opts -v /data/vendor/docker/steam:/home/wid/.steam -v /data/vendor/docker/xdg_config:/home/wid/xdg_config -v /data/vendor/docker/Games:/home/wid/Games -e CONTAINER_ID=1 --name gamecore --hostname gamecore"
    if [ $privileged == "true" ]; then
      docker create $create_opts --privileged gamecore
    else
      if [ -c /dev/video50 ]; then
        docker create $create_opts --security-opt seccomp=unconfined --security-opt apparmor=unconfined --device-cgroup-rule='a *:* rmw' -v /sys:/sys:rw --device $device --device /dev/snd --device /dev/tty0 --device /dev/tty1 --device /dev/tty2 --device /dev/tty3 --device /dev/video50 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN gamecore
      else
        docker create $create_opts --security-opt seccomp=unconfined --security-opt apparmor=unconfined --device-cgroup-rule='a *:* rmw' -v /sys:/sys:rw --device $device --device /dev/snd --device /dev/tty0 --device /dev/tty1 --device /dev/tty2 --device /dev/tty3 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN gamecore
      fi
    fi
  fi

  if [ $ai_build == "true" ]; then
    msg "create aicore container..."
    docker create -ti --network=host -e http_proxy=$http_proxy -e https_proxy=$https_proxy -v /dev/binder:/dev/binder -v /data/vendor/neuralnetworks/:/home/wid/.ipc/ --memory=$memory_size --name aicore --hostname aicore --security-opt seccomp=unconfined --security-opt apparmor=unconfined --device-cgroup-rule='a *:* rmw' -v /sys:/sys:rw --device $device --device /dev/snd --device /dev/tty0 --device /dev/tty1 --device /dev/tty2 --device /dev/tty3 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN aicore
  fi

  msg "Done!"
}

function uninstall() {
  cleanup_container $CORECONTAINERS
  cleanup_image $COREIMAGES
}

function start() {
  start_container $CORECONTAINERS
}

function stop() {
  stop_container $CORECONTAINERS
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
