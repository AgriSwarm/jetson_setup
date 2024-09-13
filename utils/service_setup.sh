#!/bin/bash

# エラーが発生した場合にスクリプトを停止
set -e

# サービスファイルのディレクトリ
CONFIG_DIR="$HOME/workspace/setup/configs"

# サービスファイルの拡張子
SERVICE_EXT=".service"

# root権限チェック
if [ "$EUID" -ne 0 ]; then
    echo "このスクリプトはroot権限で実行する必要があります。" >&2
    exit 1
fi

# configs直下のサービスファイルを処理
for service_file in "$CONFIG_DIR"/*"$SERVICE_EXT"; do
    if [ -f "$service_file" ]; then
        service_name=$(basename "$service_file")
        
        echo "処理中: $service_name"
        
        # サービスファイルをシステムディレクトリにコピー
        cp "$service_file" /etc/systemd/system/ || { echo "エラー: $service_name のコピーに失敗しました。" >&2; exit 1; }
        
        # サービスを有効化
        systemctl enable "$service_name" || { echo "エラー: $service_name の有効化に失敗しました。" >&2; exit 1; }
        
        # サービスを開始
        # systemctl start "$service_name" || { echo "エラー: $service_name の開始に失敗しました。" >&2; exit 1; }
        
        echo "$service_name を登録し、有効化しました。"
    fi
done

# systemdをリロード
systemctl daemon-reload || { echo "エラー: systemdのリロードに失敗しました。" >&2; exit 1; }

echo "すべてのサービスの設定が完了しました。"