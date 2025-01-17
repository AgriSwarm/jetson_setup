#!/bin/bash
set -e

sudo apt update && \
sudo apt install python3-pip -y && \
pip install -U pip && \
pip install gdown ultralytics pytorch_lightning==2.4  && \
pip uninstall torch torchvision -y && \
pip install https://github.com/ultralytics/assets/releases/download/v0.0.0/torch-2.1.0a0+41361538.nv23.06-cp38-cp38-linux_aarch64.whl && \
pip install https://github.com/ultralytics/assets/releases/download/v0.0.0/torchvision-0.16.2+c6f3977-cp38-cp38-linux_aarch64.whl

cd ~/catkin_ws/src || exit 1

git clone git@github.com:AgriSwarm/agri_eye_ros1.git && \
catkin build agri_eye_ros1 -j3 && \
cd agri_eye_ros1 && \
gdown --folder https://drive.google.com/drive/folders/1ZTPCMsVKrVsWRsSwFc1HvILACLVmPjRv && \

echo 'export PYTHONPATH=~/catkin_ws/src/agri_eye_ros1/pose_estimator:$PYTHONPATH' >> ~/.bashrc