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

from adaptors.ovms.interface import OvmsInterface
from adaptors.ovtoolkit.interface import OvtkInterface
import sys


def createInterfaceObj(interface_type, serving_address, serving_port,
                       serving_model_name, dir_path):
    if(interface_type == 'ovms'):
        return OvmsInterface(serving_address, serving_port, serving_model_name, dir_path)
    elif(interface_type == 'ovtk'):
        return OvtkInterface(dir_path)
    else:
        print("Error: Interface {} is not supported".format(interface_type))
        sys.exit(1)
