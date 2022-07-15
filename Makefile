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

BASE    ?= ubuntu20.04
VULKAN  ?= 1.3
CUDA_VERSION    ?= 11.4.2
DRIVER  ?= 470

FULL_VERSION := $(VULKAN)-$(DRIVER)

.PHONY: all
all: ubuntu

push:
	$(DOCKER) push "$(REGISTRY)/vulkan:$(FULL_VERSION)"

push-short:
	$(DOCKER) push "$(REGISTRY)/vulkan:$(VULKAN)"

push-latest:
	$(DOCKER) push "$(REGISTRY)/vulkan:$(VULKAN)"

ubuntu:
	$(DOCKER) build --pull \
		--build-arg BASE_DIST=$(BASE) \
		--build-arg CUDA_VERSION=$(CUDA) \
	   	--build-arg VULKAN_SDK_VERSION=$(VULKAN) \
	   	--build-arg DRIVER_VERSION=$(DRIVER) \
	    --file Dockerfile.ubuntu .
