#!/bin/bash

sudo apt-get -y update && \
sudo TZ=japan apt-get -y install tzdata && \
sudo apt-get install -y \
    wget \
    curl \
    lsb-release \
    git \
    libatlas-base-dev \
    libeigen3-dev \
    libgoogle-glog-dev \
    libsuitesparse-dev \
    libglib2.0-dev \
    libyaml-cpp-dev \
    libdw-dev libdwarf-dev \
    python3-pip \
    libopenblas-dev \
    libgtk2.0-dev \
    libssl-dev \
    libxrandr-dev \
    libusb-1.0-0-dev \
    libudev-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    at \
    linux-headers-generic \
    dkms