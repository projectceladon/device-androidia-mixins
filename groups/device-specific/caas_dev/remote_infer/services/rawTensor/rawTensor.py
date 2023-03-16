#
# Copyright (c) 2022 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

import argparse
import logging
import sys
import grpc
import datetime
import numpy as np
from concurrent import futures
import nnhal_raw_tensor_pb2
import nnhal_raw_tensor_pb2_grpc
import adaptors.create_interface as create_interface


class Detection(nnhal_raw_tensor_pb2_grpc.DetectionServicer):
    def prepare(self, requestStr, context):
        interface.prepareDir()
        return nnhal_raw_tensor_pb2.ReplyStatus(status=True)

    def sendXml(self, requestChunks, context):
        interface.saveXML(requestChunks)
        return nnhal_raw_tensor_pb2.ReplyStatus(status=True)

    def sendBin(self, requestChunks, context):
        interface.saveBin(requestChunks)
        return nnhal_raw_tensor_pb2.ReplyStatus(status=True)

    def getInferResult(self, request, context):
        start_time = datetime.datetime.now()
        reply_data_tensor = nnhal_raw_tensor_pb2.ReplyDataTensors()
        if not interface.isModelLoaded(2000):#Wait upto 2 seconds for model load
            print("Model Load Failure")
            return reply_data_tensor
        run_start_time = datetime.datetime.now()
        #decoding the grpc request and sending to adapter
        input = {}
        for datatensor in request.data_tensors:
            node_name = datatensor.node_name
            input_shape = datatensor.tensor_shape
            img_data = datatensor.data
            data = np.frombuffer(img_data, np.dtype('<f'))
            input[node_name] = (data, input_shape)

        result = interface.run_detection(input)
        end_time = datetime.datetime.now()
        serving_duration = (end_time - run_start_time).total_seconds() * 1000
        #Modifed according to the new interface output format
        for key in result.keys():
            output_data_tensor = reply_data_tensor.data_tensors.add()
            output_data_tensor.data = result[key][0].tobytes()
            output_data_tensor.node_name = key
            shape = result[key][1]
            output_data_tensor.tensor_shape.extend(shape)
        end_time = datetime.datetime.now()
        duration = (end_time - start_time).total_seconds() * 1000
        print("time in ms run_detection: {} getInferResult: {}".format(serving_duration,
                                                                            duration))
        return reply_data_tensor

def serve(port):
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    nnhal_raw_tensor_pb2_grpc.add_DetectionServicer_to_server(Detection(), server)
    server.add_insecure_port('[::]:{}'.format(port))
    server.start()
    server.wait_for_termination()

if __name__ == '__main__':
    logging.basicConfig()
    global interface
    parser = argparse.ArgumentParser(description='Remote Inference from NNHAL')
    parser.add_argument('--remote_port', required=False, default=50051,
                        help='Specify port to grpc service. default: 50051')
    parser.add_argument('--serving_address', required=False, default='localhost',
                        help='Specify url to inference service. default:localhost')
    parser.add_argument('--serving_port', required=False, default=9000,
                        help='Specify port to inference service. default: 9000')
    parser.add_argument('--serving_mounted_modelDir', required=True,
                        help='Specify full path to mounted Directory for model loading.')
    parser.add_argument('--serving_model_name', required=False, default='remote_model',
                        help='Specify model name set for inference service.')
    parser.add_argument('--interface', required=False, default='ovms',
                        help='Specify serving interface: currently supported interface \'ovms\'\
                         and \'ovtk\' for dynamically selecting the interface')
    args = vars(parser.parse_args(sys.argv[1:]))
    dir_path = args['serving_mounted_modelDir']
    serving_address = args['serving_address']
    serving_port = args['serving_port']
    adapter = args['interface']
    serving_model_name = args['serving_model_name']
    interface = create_interface.createInterfaceObj(adapter, serving_address, serving_port,
                                                    serving_model_name, dir_path)
    serve(args['remote_port'])
