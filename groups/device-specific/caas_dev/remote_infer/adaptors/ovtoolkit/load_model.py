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

import os
import shutil
import datetime


class ModelLoader:
    def __init__(self):
        self.loaded_flag = False
        self.DIR_PATH = ''
        self.XML_PATH = ''
        self.BIN_PATH = ''

    def setModelDir(self, path):
        self.DIR_PATH = path
        self.XML_PATH = self.DIR_PATH + "1/remote_model.xml"
        self.BIN_PATH = self.DIR_PATH + "1/remote_model.bin"

    def prepareDir(self):
        files = os.listdir(self.DIR_PATH)
        self.loaded_flag = False
        full_path = self.DIR_PATH + '1'
        #cleaning if any previous model is loaded
        if os.path.isfile(full_path):
            os.remove(full_path)
        elif os.path.isdir(full_path):
            shutil.rmtree(full_path)
        os.mkdir(full_path)

    def saveXML(self, requestChunks):
        start_time = datetime.datetime.now()
        with open(self.XML_PATH, 'wb') as out_file:
            for chunk in requestChunks:
                print("xml chunk size {}".format(len(chunk.data)))
                out_file.write(chunk.data)
        end_time = datetime.datetime.now()
        duration = (end_time - start_time).total_seconds() * 1000
        print("saveXML time in ms {} ".format(duration))

        return True

    def saveBin(self, requestChunks):
        start_time = datetime.datetime.now()
        with open(self.BIN_PATH, 'wb') as out_file:
            for chunk in requestChunks:
                print("bin chunk size {}".format(len(chunk.data)))
                out_file.write(chunk.data)
        end_time = datetime.datetime.now()
        duration = (end_time - start_time).total_seconds() * 1000
        print("saveBin time in ms {} ".format(duration))

        return True

    #Make sure this is called at least once
    def isModelLoaded(self, interface_obj, timeout_in_ms):
        curr_status = 0
        AVAILABLE = 30
        #To check if model is already loaded
        if(self.loaded_flag):
            return True

        start_time = datetime.datetime.now()
        last_print_delay = 0
        while(curr_status != AVAILABLE):
            curr_status = interface_obj.load_model(self.XML_PATH)
            curr_time = datetime.datetime.now()
            elapsed_time = (curr_time-start_time).total_seconds()*1000
            if((elapsed_time - last_print_delay) > 100):
                last_print_delay = elapsed_time
                print("Model not loaded yet")
            if(elapsed_time > timeout_in_ms):
                break
        if(curr_status == AVAILABLE):
            print("Model Loaded successfully")
            self.loaded_flag = True
            return True

        return False
