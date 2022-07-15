#!/bin/bash

EXAMPLES=/build/Vulkan/build/bin/
for i in $(ls ${EXAMPLES}); do
        echo 'y' | ${EXAMPLES}/$i
        echo "\n"
done