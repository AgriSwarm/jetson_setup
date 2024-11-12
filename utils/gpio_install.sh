#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

cd $HOME/workspace/setup || exit 1
git clone https://github.com/pjueon/JetsonGPIO && \
cd JetsonGPIO && \
mkdir build && cd build && \
sudo cmake .. && \
sudo cmake --build . --target install