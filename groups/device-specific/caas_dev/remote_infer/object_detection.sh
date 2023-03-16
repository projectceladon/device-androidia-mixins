#!/bin/bash
MODEL_DIR=$HOME/test_model_name
MODEL_PATH=/models/remote_model
MODEL_NAME=remote_model
SCRIPT_PATH=/ie-serving-py/start_server.sh
PYTHON_PATH=$(pwd)
SERVICE_DIR=$(pwd)/services/rawTensor
ADAPTOR_DIR=$(pwd)/adaptors/ovms
PROTO_FILE=nnhal_raw_tensor.proto
SERVER_FILE=$SERVICE_DIR/rawTensor.py
OVMS_INTERFACE_FILE=$ADAPTOR_DIR/interface.py
LOAD_MODEL_FILE=$ADAPTOR_DIR/load_model.py
OPENVINO_IMAGE=openvino/ubuntu18_model_server

function model_run {
    if [ ! -z "$($DOCKER ps | awk '{print $2}' | grep -E $OPENVINO_IMAGE)" ]; then
        echo "Openvino Container already runing"
    else
        if [ ! -z "$($DOCKER images| grep -E $OPENVINO_IMAGE)" ]; then
            echo "Runing container"
            $DOCKER run -d -v $MODEL_DIR:$MODEL_PATH -e LOG_LEVEL=DEBUG -p 9008:9008 $OPENVINO_IMAGE $SCRIPT_PATH ie_serving model --model_path $MODEL_PATH --model_name $MODEL_NAME --port 9008
        else
            echo "Openvino image not present"
            exit -1
        fi
    fi
}

function run_python_utility {
    if [ ! -e "$SERVICE_DIR/$PROTO_FILE" ]; then
        echo "Not able to generate python files for the proto file"
        exit -1
    else
        python3 -m grpc_tools.protoc -I $SERVICE_DIR --python_out=$SERVICE_DIR --grpc_python_out=$SERVICE_DIR --proto_path=$SERVICE_DIR $PROTO_FILE
    fi

    if [ ! -f $SERVER_FILE ] && [ ! -f $LOAD_MODEL_FILE ] && [ ! -f $OVMS_INTERFACE_FILE ]; then
        echo "Python Bridge start script not avaliable"
        exit -1
    else
        echo "Ready for remote inferencing"
        python3 $SERVER_FILE --serving_mounted_modelDir $MODEL_DIR/ --serving_port 9008 --interface ovms
    fi
}

echo "Starting Remote Inference Service bash Script"
if [ -z "$(docker ps 2>/dev/null)" ]; then
    DOCKER="sudo docker"
else
    DOCKER="docker"
fi

export PYTHONPATH=$PYTHON_PATH
model_run
run_python_utility
#!/bin/bash
