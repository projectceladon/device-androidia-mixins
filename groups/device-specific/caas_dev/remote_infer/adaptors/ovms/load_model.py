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
        self.version_counter = 0
        self.loaded_version = -1
        self.DIR_PATH = ''
        self.XML_PATH = ''
        self.BIN_PATH = ''

    def setModelDir(self, path):
        self.DIR_PATH = path
        self.XML_PATH = self.DIR_PATH + "{}/remote_model.xml"
        self.BIN_PATH = self.DIR_PATH + "{}/remote_model.bin"

    def prepareDir(self):
        #Using model version: 1,2,3
        self.version_counter = self.version_counter%3 +1
        self.loaded_version = -1
        files = os.listdir(self.DIR_PATH)
        for i in files:
            full_path = self.DIR_PATH + i
            if os.path.isfile(full_path):
                os.remove(full_path)
            elif os.path.isdir(full_path):
                shutil.rmtree(full_path)
            else:
                print("Not deleting {} ".format(full_path))
        os.mkdir(self.DIR_PATH + str(self.version_counter))

    def saveXML(self, requestChunks):
        start_time = datetime.datetime.now()
        with open(self.XML_PATH.format(self.version_counter), 'wb') as out_file:
            for chunk in requestChunks:
                print("xml chunk size {}".format(len(chunk.data)))
                out_file.write(chunk.data)
        end_time = datetime.datetime.now()
        duration = (end_time - start_time).total_seconds() * 1000
        print("saveXML time in ms {} ".format(duration))

        return True

    def saveBin(self, requestChunks):
        start_time = datetime.datetime.now()
        with open(self.BIN_PATH.format(self.version_counter), 'wb') as out_file:
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
        if(self.loaded_version==self.version_counter):
            return True
        start_time = datetime.datetime.now()
        last_print_delay = 0
        #adding this for object Detection and FaceMaskDetection as version is not required
        #so statically adding version, version 0 is invalid so reseting to 1
        if(self.version_counter == 0):
            self.version_counter = 1
        while(curr_status != AVAILABLE):
            curr_status = interface_obj.checkModelStatus(curr_status, self.version_counter)
            curr_time = datetime.datetime.now()
            elapsed_time = (curr_time-start_time).total_seconds()*1000
            if((elapsed_time - last_print_delay) > 100):
                last_print_delay = elapsed_time
                print("Model version {} not loaded yet".format(self.version_counter))
            if(elapsed_time > timeout_in_ms):
                break
        if(curr_status == AVAILABLE):
            print("Model version {} loaded successfully".format(self.version_counter))
            self.loaded_version = self.version_counter
            return True

        return False
