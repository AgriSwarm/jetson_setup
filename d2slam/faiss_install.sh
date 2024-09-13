#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

FAISS_VERSION=1.7.4

cd $HOME/workspace/setup || exit 1

git clone https://github.com/facebookresearch/faiss.git && \
cd faiss && \
git checkout tags/v${FAISS_VERSION} && \
cmake -B build -DCMAKE_BUILD_TYPE=Release -DFAISS_ENABLE_PYTHON=OFF -DBUILD_TESTING=OFF -DFAISS_ENABLE_GPU=OFF . && \
sudo make -C build -j4 faiss && \
sudo make -C build -j4 install

# 以下の行はコメントアウトされていますが、必要に応じて使用できます
# sudo rm -r ~/workspace/setup/d2slam/faiss