#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

CMAKE_VERSION=3.23.1
cd $HOME/workspace/setup || exit 1

# ディレクトリが既に存在する場合にエラーを防ぐ
mkdir -p cmake_backup
mkdir -p tmp

# CMakeのバックアップを作成（既存のファイルが存在する場合のみ）
if [ -f /usr/bin/cmake ]; then
    sudo cp /usr/bin/cmake cmake_backup/ || { echo "Failed to backup CMake"; exit 1; }
fi

# 既存のCMakeを削除（存在する場合のみ）
if [ -f /usr/bin/cmake ]; then
    sudo rm /usr/bin/cmake || { echo "Failed to remove existing CMake"; exit 1; }
fi

# 新しいCMakeをダウンロードしてインストール
wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-aarch64.sh \
    -q -O ./tmp/cmake-install.sh && \
sudo chmod u+x ./tmp/cmake-install.sh && \
sudo ./tmp/cmake-install.sh --skip-license --prefix=/usr/ && \
sudo rm ./tmp/cmake-install.sh && \
sudo cmake --version || { echo "Failed to install CMake"; exit 1; }