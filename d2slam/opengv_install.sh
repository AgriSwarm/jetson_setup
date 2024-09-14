#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

cd $HOME/workspace/setup || exit 1
git clone https://github.com/HKUST-Swarm/opengv && \
mkdir opengv/build && cd opengv/build && \
sudo cmake .. && sudo make -j4 && \
sudo make -j4 install