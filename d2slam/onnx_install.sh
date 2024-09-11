ONNX_VERSION=1.12.1

sudo apt install -y libopenblas-dev
#Install ONNXRuntime with CUDA and TensorRT
cd $HOME/workspace/setup && \
      git clone --recursive git@github.com:AgriSwarm/onnxruntime.git && \
      cd onnxruntime && \
      git checkout tags/v${ONNX_VERSION}
      sudo bash ./build.sh --config Release --build_shared_lib --parallel \
      --use_cuda --cudnn_home /usr/ --cuda_home /usr/local/cuda --skip_test \
      --use_tensorrt --tensorrt_home /usr/ &&\
      cd build/Linux/Release && \
      sudo make -j4 install && \
      # rm -rf ../../../onnxruntime && \
      sudo apt install python3-pip libopenblas-dev vim -y
      # pip3 install onnxruntime-gpu==${ONNX_VERSION}
      wget https://nvidia.box.com/shared/static/v59xkrnvederwewo2f1jtv6yurl92xso.whl -O onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl && \
      pip3 install onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl && \
      sudo rm onnxruntime_gpu-1.12.1-cp38-cp38-linux_aarch64.whl
