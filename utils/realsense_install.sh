#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

cd $HOME/workspace/setup || exit 1

sudo apt-get install -y libssl-dev libxrandr-dev libusb-1.0-0-dev \
  libudev-dev pkg-config libgtk-3-dev libglfw3-dev libgl1-mesa-dev libglu1-mesa-dev at

if [ ! -d "librealsense-2.55.1" ]; then
  wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.55.1.zip -O librealsense.zip && \
  unzip librealsense.zip && \
  rm librealsense.zip
fi

cd librealsense-2.55.1
if [ ! -d "build" ]; then
  mkdir build
fi
cd build && \
sudo cmake .. && \
sudo make -j4 && \
sudo make -j4 install