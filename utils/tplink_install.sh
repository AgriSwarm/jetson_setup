#!/bin/bash

set -e
cd $HOME/workspace/setup || exit 1

if [ ! -d "RTL88x2BU-Linux-Driver-master" ]; then
    wget https://github.com/RinCat/RTL88x2BU-Linux-Driver/archive/master.zip && \
    unzip master.zip && \
    rm master.zip
fi
cd RTL88x2BU-Linux-Driver-master && \
sudo make uninstall && \
make clean && \
make && \
sudo make install && \
sudo modprobe 88x2bu \
