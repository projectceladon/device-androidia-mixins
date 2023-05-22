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

import os
import logging as log
from adaptors.base_adaptor import BaseInterface
from adaptors.ovtoolkit.load_model import ModelLoader
import datetime
import sys
if os.name == 'nt':
    from openvino.inference_engine import IECore


class OvtkInterface(BaseInterface):
    def __init__(self, path):
        super().__init__()
        self.ie = IECore()
        self.device = "CPU"
        self.net = ''
        self.exec_net = ''
        self.model_loader = ModelLoader()
        self.model_loader.setModelDir(path)

    def load_model(self, model_xml=None):
        self.device = "CPU"
        if not model_xml:
            log.error("model_xml path: \'{}\' missing".format(model_xml))
            sys.exit(1)

        # ---------- 1. Read IR Generated by ModelOptimizer (.xml and .bin files) -------------
        model_bin = os.path.splitext(model_xml)[0] + ".bin"
        log.info("Loading network files:\n\t{}\n\t{}".format(model_xml, model_bin))
        self.net = self.ie.read_network(model=model_xml, weights=model_bin)
        self.exec_net = self.ie.load_network(network=self.net, device_name=self.device)
        if "CPU" in self.device:
            supported_layers = self.ie.query_network(self.net, "CPU")
            not_supported_layers = [l for l in self.net.layers.keys() if l not in supported_layers]
            if len(not_supported_layers) != 0:
                log.error("Following layers are not supported by"
                          "the plugin for specified device {}:\n {}".
                          format(self.device, ', '.join(not_supported_layers)))

                log.error("Please try to specify cpu extensions library path"
                          "in sample's command line parameters using -l "
                          "or --cpu_extension command line argument")
                sys.exit(1)

        return 30#AVAILABLE

    def run_detection(self, input_data):
        start_time = datetime.datetime.now()

        processed_data = {}
        for key in input_data:
            input_shape = input_data[key][1]
            img = input_data[key][0].reshape(input_shape[3], input_shape[2], 3)
            img = img.transpose(2, 0, 1).reshape(1, 3, input_shape[3], input_shape[2])
            processed_data[key] = img

        curr_time = datetime.datetime.now()
        res = self.exec_net.infer(inputs=processed_data)
        end_time = datetime.datetime.now()
        predict_time = (end_time - curr_time).total_seconds() * 1000
        #returns dictionary with keyword as nodename and values :tupple of data and their shape
        response = {}
        for output_key in self.net.outputs.keys():
            response[output_key] = (res[output_key], self.net.outputs[output_key].shape)

        exit_time = datetime.datetime.now()
        input_time = (curr_time - start_time).total_seconds() * 1000
        output_time = (exit_time - end_time).total_seconds() * 1000
        print("INPUT_Prep:{} Inference_TIME:{} OUTPUT_Prep:{}".format(input_time,
                                                                      predict_time, output_time))
        return response

    def prepareDir(self):
        self.model_loader.prepareDir()

    def saveXML(self, requestChunks):
        self.model_loader.saveXML(requestChunks)

    def saveBin(self, requestChunks):
        self.model_loader.saveBin(requestChunks)

    def isModelLoaded(self, timeout_in_ms):
        return self.model_loader.isModelLoaded(self, timeout_in_ms)