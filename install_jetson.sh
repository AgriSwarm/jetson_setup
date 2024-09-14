#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e
export HOME=$(getent passwd $(logname) | cut -d: -f6)

# install dependencies
# sudo apt-get -y update && \
# sudo TZ=japan apt-get -y install tzdata && \
# sudo apt-get install -y wget curl lsb-release git \
#    libatlas-base-dev \
#    libeigen3-dev \
#    libgoogle-glog-dev \
#    libsuitesparse-dev \
#    libglib2.0-dev \
#    libyaml-cpp-dev \
#    libdw-dev libdwarf-dev \
#    python3-pip

# update cmake
# bash d2slam/cmake_update.sh

# ceres
# bash d2slam/ceres_install.sh

# librealsense
# bash utils/realsense_install.sh

# tplink
# bash utils/tplink_install.sh

# install ROS
# bash utils/ros_install.sh

# lcm
# cd $HOME/workspace/setup || exit 1
# git clone https://github.com/lcm-proj/lcm && \
# cd lcm && \
# git checkout tags/v1.4.0 && \
# mkdir build && cd build && \
# sudo cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF .. && \
# sudo make -j2 install

# opengv
# cd $HOME/workspace/setup || exit 1
# git clone https://github.com/HKUST-Swarm/opengv && \
# mkdir opengv/build && cd opengv/build && \
# sudo cmake .. && sudo make -j4 && \
# sudo make -j4 install

# backword
# sudo wget https://raw.githubusercontent.com/bombela/backward-cpp/master/backward.hpp -O /usr/local/include/backward.hpp

# libtorch
# cd $HOME/workspace/setup || exit 1
# sudo pip3 install --no-cache https://developer.download.nvidia.com/compute/redist/jp/v50/pytorch/torch-1.12.0a0+84d1cb9.nv22.4-cp38-cp38-linux_aarch64.whl

# onnx
sudo -E -u $USER bash d2slam/onnx_install.sh

# faiss
bash d2slam/faiss_install.sh

# opencv
bash d2slam/cv2_with_cuda_install.sh

# build d2slam package
cd ~/catkin_ws/src || exit 1

git clone git@github.com:AgriSwarm/swarm_msgs.git && \
git clone https://github.com/ros-perception/vision_opencv.git -b noetic && \
git clone git@github.com:AgriSwarm/d2slam.git && \
git clone git@github.com:AgriSwarm/agri_navigation_ros1.git && \
git clone git@github.com:AgriSwarm/agri_resources.git && \
git clone git@github.com:AgriSwarm/realsense-ros.git

echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export CUDA_HOME=/usr/local/cuda' >> ~/.bashrc

catkin config -DCMAKE_BUILD_TYPE=Release \
    --cmake-args -DONNXRUNTIME_LIB_DIR=/usr/local/lib/ \
    -DONNXRUNTIME_INC_DIR=/usr/local/include/onnxruntime/core/session/ \
    -DTorch_DIR=/usr/local/lib/python3.8/dist-packages/torch/share/cmake/Torch

catkin build -j3

# download frontend cnn model
cd ~/catkin_ws/src/d2slam || exit 1
rm -rf models
wget -O models.zip "https://www.dropbox.com/scl/fi/zdo90dicmqujwio22l8xn/models.zip?rlkey=hvxsmrao904lle3wnrhoid8n7&dl=1" && \
unzip models.zip && \
rm models.zip
