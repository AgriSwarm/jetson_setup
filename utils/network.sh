#!/bin/bash

# エラーが発生したら即座に終了するように設定
set -e

# 引数の数をチェック
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <SSID> <パスワード>"
    exit 1
fi

# 引数から値を取得
wifi="$1"
password="$2"

# エラーハンドリング関数
error_handler() {
    echo "エラーが発生しました: 行 $1"
    exit 1
}

# エラーが発生した行番号を取得してエラーハンドラーを呼び出す
trap 'error_handler ${LINENO}' ERR

echo "Wi-Fiに接続を試みています..."

# Wi-Fiに接続
if ! nmcli device wifi connect "$wifi" password "$password"; then
    echo "Wi-Fi接続に失敗しました"
    exit 1
fi

echo "Wi-Fi接続に成功しました"

# IPアドレスを取得（最初のアドレスのみ）
ip_address=$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

# IPアドレスが取得できたか確認
if [ -z "$ip_address" ]; then
    echo "IPアドレスの取得に失敗しました"
    exit 1
fi

# IPアドレスにサブネットマスクを追加
ip_with_mask="${ip_address}/24"

echo "IPアドレスを設定しています: $ip_with_mask"

# 接続の設定を変更
if ! sudo nmcli con mod "$wifi" ipv4.addresses "$ip_with_mask"; then
    echo "IP設定の変更に失敗しました"
    exit 1
fi

echo "Wi-Fi設定が完了しました"
echo "設定されたIPアドレス: $ip_with_mask"