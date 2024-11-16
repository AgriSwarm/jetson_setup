#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

cd $HOME/workspace/setup || exit 1
git clone https://github.com/pjueon/JetsonGPIO && \
cd JetsonGPIO && \
mkdir build && cd build && \
sudo cmake .. && \
sudo cmake --build . --target install

sudo usermod -a -G dialout $USER
sudo chmod 666 /dev/ttyTHS0
# sudo chmod 666 /dev/ttyTHS1
# sudo chmod 666 /dev/ttyTHS2
sudo chmod 666 /dev/ttyTHS3
sudo chmod 666 /dev/ttyTHS4
