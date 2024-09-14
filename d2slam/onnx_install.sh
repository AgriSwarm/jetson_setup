#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e
export HOME=$(getent passwd $(logname) | cut -d: -f6)

ONNX_VERSION=1.12.1

# Install ONNXRuntime with CUDA and TensorRT
# cd $HOME/workspace/setup || exit 1
# git clone --recursive git@github.com:AgriSwarm/onnxruntime.git && \
# cd onnxruntime && \
# git checkout tags/v${ONNX_VERSION}
# sudo bash ./build.sh --config Release --build_shared_lib --parallel \
#  --use_cuda --cudnn_home /usr/ --cuda_home /usr/local/cuda --skip_test \
#  --use_tensorrt --tensorrt_home /usr/ && \
# cd build/Linux/Release && \
# sudo make -j4 install && \
# rm -rf ../../../onnxruntime && \
# pip3 install onnxruntime-gpu==${ONNX_VERSION}
wget https://nvidia.box.com/shared/static/v59xkrnvederwewo2f1jtv6yurl92xso.whl -O onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl && \
pip3 install onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl && \
sudo rm onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl
