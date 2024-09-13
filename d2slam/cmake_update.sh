CMAKE_VERSION=3.23.1
cd $HOME/workspace/setup
mkdir cmake_backup
mkdir tmp
sudo cp /usr/bin/cmake cmake_backup/
sudo rm /usr/bin/cmake && \
      wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-aarch64.sh \
      -q -O ./tmp/cmake-install.sh \
      && sudo chmod u+x ./tmp/cmake-install.sh \
      && sudo ./tmp/cmake-install.sh --skip-license --prefix=/usr/ \
      && sudo rm ./tmp/cmake-install.sh \
      && sudo cmake --version
