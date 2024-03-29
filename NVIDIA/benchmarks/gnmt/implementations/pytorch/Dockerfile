# Copyright (c) 2018-2019, NVIDIA CORPORATION. All rights reserved.
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

ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:19.05-py3
#ARG FROM_IMAGE_NAME=nvcr.io/nvidia/pytorch:19.09-py3
FROM ${FROM_IMAGE_NAME}

# Install dependencies for system configuration logger
RUN wget https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb && dpkg -i nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb

RUN apt-get update && apt-get install -y --no-install-recommends \
        infiniband-diags \
        pciutils \
	libnccl2 libnccl-dev libcudnn7 libcudnn7-dev && \
    rm -rf /var/lib/apt/lists/* #&& rm nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb

# Install Python dependencies
WORKDIR /workspace/rnn_translator

COPY requirements.txt .
RUN pip install --no-cache-dir https://github.com/mlperf/training/archive/6289993e1e9f0f5c4534336df83ff199bd0cdb75.zip#subdirectory=compliance \
 && pip install --no-cache-dir -r requirements.txt

# Copy & build extensions
COPY seq2seq/csrc seq2seq/csrc
COPY setup.py .
RUN pip install .

# Copy GNMT code
COPY . .

# Configure environment variables
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
