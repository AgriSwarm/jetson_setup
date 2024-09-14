#!/bin/bash
set -e

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