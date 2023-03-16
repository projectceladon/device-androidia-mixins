#!/bin/bash
MODEL_DIR=/home/$SUDO_USER/test_model_name
OPENVINO_IMAGE=openvino/ubuntu18_model_server
CLIENT_REQ_FILE=client_requirements.txt

function check_docker {
    if [ ! -x "$(command -v docker)" ]; then
        echo "Installing docker"
        sudo apt -y install docker.io
        sudo usermod -aG docker $USER
    fi
    user=`grep intel /etc/group | awk -F: '{print $1}'|grep docker`
    if [ -z "$user" ]; then
        echo "adding docker user"
        sudo usermod -aG docker $SUDO_USER
    fi
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

function set_docker_proxy {
    if [ ! -d "/etc/systemd/system/docker.service.d" ]; then
        sudo mkdir -p /etc/systemd/system/docker.service.d

    else
        if [ -e "/etc/systemd/system/docker.service.d/http-proxy.conf" ]; then
            return
        fi
    fi
    cat <<EOF | sudo tee -a /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=$http_proxy"
Environment="HTTPS_PROXY=$https_proxy"
EOF
    sudo systemctl daemon-reload
    sudo systemctl restart docker
}

function check_image {
    if [ ! -z "$($DOCKER images| grep -E $OPENVINO_IMAGE)" ]; then
        echo "Openvino image already present"
    else
        echo "Fetching openvino image"
        set_docker_proxy
        $DOCKER pull $OPENVINO_IMAGE:latest
    fi
}

function setup_model_dir {
    if [ -d "$MODEL_DIR" ]; then
        if [ ! -d "$MODEL_DIR/1" ]; then
            su - $SUDO_USER -c "rm -rfd $MODEL_DIR/*"
        fi
    else
        su - $SUDO_USER -c "mkdir $MODEL_DIR"
    fi
}

function check_requirements {
    if [ ! -e "$(pwd)/scripts/remote_infer/$CLIENT_REQ_FILE" ]; then
        #curl $CLIENT_REQ_LINK$CLIENT_REQ_FILE -o $CLIENT_REQ_FILE
        echo "Client Requirement file to enable remote inferencing not present"
        exit -1
    fi

    if [ ! -x "$(command -v pip3)" ]; then
        echo " Installing Python-pip"
        sudo apt-get -y install python3-pip
    fi

    version=$(pip3 -V 2>&1 | grep -Po '(?<=pip )\d+')
    if [ "$version" -lt "19" ]; then
        echo "Upgrading Python-pip version"
        pip3 install --upgrade pip
    fi

    echo "Checking requirements to run the remote inferencing being met or not"
    python3 -m pip install -r scripts/remote_infer/client_requirements.txt
}

function check_env_proxy {
    a=`grep -rn "no_proxy\=\".*localhost.*\"" /home/$SUDO_USER/.bashrc`
    b=`grep -rn "no_proxy" /home/$SUDO_USER/.bashrc`
    echo "Checking for environment no_proxy settings"

    if [ -z "$b" ]; then
        echo "export no_proxy=\"localhost\"" | sudo tee -a /home/$SUDO_USER/.bashrc
    elif [ -z "$a" ]; then
        sudo sed -i "s|export no_proxy.*||g" $HOME/.bashrc
        echo "export no_proxy=\"$no_proxy,localhost\"" | sudo tee -a /home/$SUDO_USER/.bashrc
    fi
}

function setup_infer_service {
    echo "Adding Remote Inferencing Service"
    sudo touch /lib/systemd/system/remote_infer.service

    cat << EOF | sudo tee /lib/systemd/system/remote_infer.service
[Unit]
Description="Start/Stop Remote Inferencing"

[Service]
User=$SUDO_USER
WorkingDirectory=$(pwd)/scripts/remote_infer/
Type=simple
ExecStart=/bin/bash object_detection.sh

[Install]
WantedBy=multi-user.target
EOF
    sudo systemctl enable remote_infer
    sudo systemctl start remote_infer
}
echo "Starting Remote Inferencing Setup Script"
check_docker
if [ -z "$(docker ps 2>/dev/null)" ]; then
    DOCKER="sudo docker"
else
    DOCKER="docker"
fi

check_image
setup_model_dir
check_requirements
check_env_proxy
setup_infer_service
#!/bin/bash
