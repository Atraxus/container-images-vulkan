# Copyright (c) 2021, NVIDIA CORPORATION.  All rights reserved.
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

DOCKER   ?= docker
REGISTRY ?= nvidia

FULL_VERSION := $(VULKAN)-$(DRIVER)

.PHONY: all
all: ubuntu

ubuntu:
	$(DOCKER) build -t vulkan:rayx --pull \
		--build-arg BASE_DIST=ubuntu22.04 \
		--build-arg CUDA_VERSION=11.8.0 \
	   	--build-arg VULKAN_SDK_VERSION=`curl -sk https://vulkan.lunarg.com/sdk/latest/linux.txt` \
	    	--file docker/Dockerfile.ubuntu .

run: 
	$(DOCKER) run \
	       	--gpus all \
   	        -e NVIDIA_DISABLE_REQUIRE=1 \
                -e NVIDIA_DRIVER_CAPABILITIES=all --device /dev/dri \
   		-v /etc/vulkan/icd.d/nvidia_icd.json:/etc/vulkan/icd.d/nvidia_icd.json \
   		-v /etc/vulkan/implicit_layer.d/nvidia_layers.json:/etc/vulkan/implicit_layer.d/nvidia_layers.json \
   		-v /usr/share/glvnd/egl_vendor.d/10_nvidia.json:/usr/share/glvnd/egl_vendor.d/10_nvidia.json \
		-it vulkan:rayx \
    		bash
