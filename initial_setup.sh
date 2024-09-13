#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e
export HOME=$(getent passwd $(logname) | cut -d: -f6)

# create dirs
mkdir -p ~/workspace/setup
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# app
sudo apt update && \
sudo apt -y install emacs nano && \
sudo apt install -uy firefox && \
echo 'alias emacs="emacs -nw"' >> ~/.bashrc

# git
cd $HOME/workspace/setup || exit 1
rm -f $HOME/.gitconfig
cp configs/.gitconfig $HOME || exit 1
git clone https://github.com/holygeek/git-number && \
cd git-number && \
sudo cp git-* /usr/local/bin && \
cd ../
# rm -rf git-number

# cron
MEMORY_SCRIPT="$SCRIPT_DIR/utils/check_mem.sh"
chmod +x $MEMORY_SCRIPT
(crontab -l 2>/dev/null; echo "*/1 * * * * $MEMORY_SCRIPT") | crontab -

# github-ssh
KEY_TYPE="ed25519"
KEY_FILE="$HOME/.ssh/id_${KEY_TYPE}"
KEY_COMMENT="automated_key_$(date +%Y%m%d)"

mkdir -p $HOME/.ssh
cp "$SCRIPT_DIR/configs/authorized_keys" $HOME/.ssh/authorized_keys || exit 1

cd $HOME/.ssh || exit 1
ssh-keygen -t $KEY_TYPE -f "$KEY_FILE" -N "" -C "$KEY_COMMENT" && \
cat "${KEY_FILE}.pub" && \
echo "SSH key pair has been generated and saved in $KEY_FILE"