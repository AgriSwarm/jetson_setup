#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

cd $HOME/workspace/setup || exit 1
git clone https://github.com/lcm-proj/lcm && \
cd lcm && \
git checkout tags/v1.4.0 && \
mkdir build && cd build && \
sudo cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF .. && \
sudo make -j2 install