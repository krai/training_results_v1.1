# Copyright (c) 2018-2021, NVIDIA CORPORATION.  All rights reserved.
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

import ctypes
import math
import os

import pynvml

pynvml.nvmlInit()


def l2_promote():
    _libcudart = ctypes.CDLL('libcudart.so')
    # Set device limit on the current device
    # cudaLimitMaxL2FetchGranularity = 0x05
    pValue = ctypes.cast((ctypes.c_int*1)(), ctypes.POINTER(ctypes.c_int))
    _libcudart.cudaDeviceSetLimit(ctypes.c_int(0x05), ctypes.c_int(128))
    _libcudart.cudaDeviceGetLimit(pValue, ctypes.c_int(0x05))
    assert pValue.contents.value == 128


def systemGetDriverVersion():
    return pynvml.nvmlSystemGetDriverVersion()


def deviceGetCount():
    return pynvml.nvmlDeviceGetCount()


class device:
    # assume nvml returns list of 64 bit ints
    _nvml_affinity_elements = math.ceil(os.cpu_count() / 64)

    def __init__(self, device_idx):
        super().__init__()
        self.handle = pynvml.nvmlDeviceGetHandleByIndex(device_idx)

    def getName(self):
        return pynvml.nvmlDeviceGetName(self.handle)

    def getCpuAffinity(self):
        affinity_string = ''
        for j in pynvml.nvmlDeviceGetCpuAffinity(
            self.handle, device._nvml_affinity_elements
        ):
            # assume nvml returns list of 64 bit ints
            affinity_string = '{:064b}'.format(j) + affinity_string
        affinity_list = [int(x) for x in affinity_string]
        affinity_list.reverse()  # so core 0 is in 0th element of list

        return [i for i, e in enumerate(affinity_list) if e != 0]


def set_affinity(gpu_id):
    dev = device(gpu_id)
    os.sched_setaffinity(0, dev.getCpuAffinity())

    # list of ints representing the logical cores this process is now affinitied with
    return os.sched_getaffinity(0)
