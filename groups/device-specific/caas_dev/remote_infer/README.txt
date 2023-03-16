Copyright (c) 2022 Intel Corporation

General Setup Steps:
There are two ways you can setup remote infer
a) Recommended: By running setup script which is named as
                i)  if you are doing it first time use setup_rinfer_host.sh
                ii) if dependency packages and docker are already installed, then run objectdetection.sh

        To Control Remote Infer Service(only if you installed it using setup_rinfer_host.sh):
            a) check status of service
                sudo systemctl status remote_infer.service

            b) if service is inactive, start the service via
                sudo systemctl start remote_infer.service

            c) To stop service
                sudo systemctl stop remote_infer.service

            d) To disable and remove service
                sudo systemctl disable remote_infer.service

b) Second manually: Use it only for debug purpose:
    Prequistes:
        Make sure docker is installed and proper proxy are set

    1) cd remote_infer
    2) export PYTHONPATH="$PWD"
    3) install python packages:
        python3 -m pip install -r client_requirements.txt
    4) create a folder to hold the models:
        mkdir -p test_model_name/1

    Steps For Runing Raw Tensor service:
    Prerequiste:
        OpenVINO Model Server(OVMS) image is pulled
            docker pull openvino/ubuntu18_model_server:latest

    TO RUN WITH OVMS:
    5) cd services/rawTensor
    6) generate proto python file from the proto file
            python3 -m grpc_tools.protoc -I ./ --python_out=. --grpc_python_out=. --proto_path=. nnhal_raw_tensor.proto
    7) docker run -d -v $(pwd)/test_model_name:/models/remote_model -e LOG_LEVEL=DEBUG -p 9008:9008 openvino/ubuntu18_model_server /ie-serving-py/start_server.sh ie_serving model --model_path /models/remote_model --model_name remote_model --port 9008
    8) python3 rawTensor.py --serving_mounted_modelDir $(pwd)/test_model_name/ --serving_port 9008 --interface ovms

    Note: For now OpenVino Toolkit(OVTK) is not recommended and tested for remote infer,
    but if you want try it out make sure you have installed openvino toolkit first
    TO RUN WITH OVTK:
    7)   python3 rawTensor.py --serving_mounted_modelDir test_model_name/ --serving_port 9008 --interface ovtk
