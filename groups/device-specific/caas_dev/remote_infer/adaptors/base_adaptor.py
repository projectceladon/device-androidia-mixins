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

import logging as log
import sys


class BaseInterface:
    def isModelLoaded(self, timeout_in_ms):
        log.error("Subclass  Implementation for api:isModelLoaded(timeout_in_ms) Missing")
        sys.exit(1)

    def run_detection(self, input_data):
        log.error("Subclass Implementation for api:run_detection(input_data) Missing")
        sys.exit(1)
