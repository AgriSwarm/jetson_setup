cd $HOME/workspace/setup
git clone https://github.com/HKUST-Swarm/ceres-solver -b D2SLAM && \
cd ceres-solver && \
mkdir build && cd build && \
sudo cmake  -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF -DBUILD_BENCHMARKS=OFF -DCUDA=OFF .. && \
sudo make -j2 install