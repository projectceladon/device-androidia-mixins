#
# Copyright (c) 2022 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import datetime
import grpc
import tensorflow as tf
from tensorflow import make_tensor_proto, make_ndarray
from adaptors.base_adaptor import BaseInterface
from adaptors.ovms.load_model import ModelLoader
from tensorflow_serving.apis import predict_pb2
from tensorflow_serving.apis import prediction_service_pb2_grpc
from tensorflow_serving.apis import model_service_pb2_grpc
from tensorflow_serving.apis import get_model_status_pb2


class OvmsInterface(BaseInterface):
    def __init__(self, ovms_address, ovms_port, model_name, path):
        super().__init__()
        self.grpc_address = ovms_address
        self.grpc_port = ovms_port
        self.model_name = model_name
        self.state_names = {
            0: "UNKNOWN",
            10: "START",
            20: "LOADING",
            30: "AVAILABLE",
            40: "UNLOADING",
            50: "END"
        }
        self.model_loader = ModelLoader()
        self.model_loader.setModelDir(path)

    def checkModelStatus(self, curr_state, version=1):
        print('Checking Model Status')
        channel = grpc.insecure_channel("{}:{}".format(self.grpc_address, self.grpc_port))
        stub = model_service_pb2_grpc.ModelServiceStub(channel)
        request = get_model_status_pb2.GetModelStatusRequest()
        request.model_spec.name = self.model_name
        request.model_spec.version.value = version
        try:
            response = stub.GetModelStatus(request, 10.0)
        except Exception as inst:
            print(type(inst))    # the exception instance
            print(inst)
            return 0

        version_status = response.model_version_status
        for i in version_status:
            if version == i.version:
                if i.state != curr_state:
                    print("State", self.state_names[i.state])
                    print("Error code: ", i.status.error_code)
                    print("Error message: ", i.status.error_message)
                return i.state
        return 0

    def run_detection(self, input_data):
        channel = grpc.insecure_channel("{}:{}".format(self.grpc_address, self.grpc_port))
        stub = prediction_service_pb2_grpc.PredictionServiceStub(channel)
        request = predict_pb2.PredictRequest()
        request.model_spec.name = self.model_name

        for key in input_data:
            input_shape = input_data[key][1]
            img = input_data[key][0]
            img = img.reshape(input_shape[0],input_shape[1], input_shape[2], input_shape[3])
            request.inputs[key].CopyFrom(make_tensor_proto(img, dtype=tf.float32,\
                                                           shape=(img.shape)))

        start_time = datetime.datetime.now()
        result = stub.Predict(request, 10.0)
        #returns dictionary with keyword as nodename and values :tupple of data and their shape
        response = {}
        for key in result.outputs.keys():
            shape = [d.size for d in result.outputs[key].tensor_shape.dim]
            response[key] = (make_ndarray(result.outputs[key]),shape)

        end_time = datetime.datetime.now()
        duration = (end_time - start_time).total_seconds() * 1000
        print("Predict time in ms: ", duration)

        return response

    def prepareDir(self):
        self.model_loader.prepareDir()

    def saveXML(self, requestChunks):
        self.model_loader.saveXML(requestChunks)

    def saveBin(self, requestChunks):
        self.model_loader.saveBin(requestChunks)

    def isModelLoaded(self, timeout_in_ms):
        return self.model_loader.isModelLoaded(self, timeout_in_ms)
