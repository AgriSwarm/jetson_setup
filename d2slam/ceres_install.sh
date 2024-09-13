#!/bin/bash

set -e

cd $HOME/workspace/setup || exit 1

if [ ! -d "ceres-solver" ]; then
    git clone https://github.com/HKUST-Swarm/ceres-solver -b D2SLAM
fi

cd ceres-solver && \
mkdir -p build && \
cd build && \
sudo cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF -DCUDA=OFF .. && \
sudo make -j2 install