#!/bin/bash

# サービスファイルのディレクトリ
CONFIG_DIR="$HOME/workspace/setup/configs"

# サービスファイルの拡張子
SERVICE_EXT=".service"

# root権限チェック
if [ "$EUID" -ne 0 ]; then
    echo "このスクリプトはroot権限で実行する必要があります。"
    exit 1
fi

# configs直下のサービスファイルを処理
for service_file in "$CONFIG_DIR"/*"$SERVICE_EXT"; do
    if [ -f "$service_file" ]; then
        service_name=$(basename "$service_file")
        
        echo "処理中: $service_name"
        
        # サービスファイルをシステムディレクトリにコピー
        cp "$service_file" /etc/systemd/system/
        
        # サービスを有効化
        systemctl enable "$service_name"
        
        # サービスを開始
        # systemctl start "$service_name"
        
        echo "$service_name を登録し、有効化しました。"
    fi
done

# systemdをリロード
systemctl daemon-reload

echo "すべてのサービスの設定が完了しました。"