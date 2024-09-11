#!/bin/bash

cd $HOME/workspace/setup

wget https://github.com/IntelRealSense/librealsense/archive/refs/tags/v2.55.1.zip -O librealsense.zip && \
unzip librealsense.zip && \
cd librealsense-2.55.1 && \
mkdir build && cd build && \
sudo cmake .. && \
sudo make -j4 && \
sudo make -j4 install && \