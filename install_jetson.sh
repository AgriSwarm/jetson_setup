#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

sudo -E -u $USER bash utils/install_dependencies.sh
sudo -E -u $USER bash d2slam/cmake_update.sh
sudo -E -u $USER bash d2slam/ceres_install.sh
sudo -E -u $USER bash utils/realsense_install.sh
sudo -E -u $USER bash utils/tplink_install.sh
sudo -E -u $USER bash utils/ros_install.sh
sudo -E -u $USER bash utils/lcm_install.sh
sudo -E -u $USER bash utils/opengv_install.sh
sudo wget https://raw.githubusercontent.com/bombela/backward-cpp/master/backward.hpp -O /usr/local/include/backward.hpp
sudo pip3 install --no-cache https://developer.download.nvidia.com/compute/redist/jp/v50/pytorch/torch-1.12.0a0+84d1cb9.nv22.4-cp38-cp38-linux_aarch64.whl
sudo -E -u $USER bash d2slam/onnx_install.sh
sudo -E -u $USER bash d2slam/faiss_install.sh
sudo -E -u $USER bash d2slam/cv2_with_cuda_install.sh
sudo -E -u $USER bash setup_ros_pkg.sh