#!/bin/bash

# エラーが発生した場合にスクリプトを停止し、未定義の変数を使用した場合にもエラーとする
set -eu
# パイプの左側のコマンドが失敗した場合もエラーとする
set -o pipefail

# サービスファイルのディレクトリ
CONFIG_DIR="/home/initial/workspace/setup/configs"

# サービスファイルの拡張子
SERVICE_EXT=".service"

# ログ関数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# エラーログ関数
error_log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] エラー: $1" >&2
}

# クリーンアップ関数
cleanup() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        error_log "スクリプトが異常終了しました。(終了コード: $exit_code)"
    fi
    exit $exit_code
}

# クリーンアップ関数を登録
trap cleanup EXIT

# root権限チェック
if [ "$EUID" -ne 0 ]; then
    error_log "このスクリプトはroot権限で実行する必要があります。"
    exit 1
fi

# 必要なディレクトリの存在確認
if [ ! -d "$CONFIG_DIR" ]; then
    error_log "設定ディレクトリが見つかりません: $CONFIG_DIR"
    exit 1
fi

# バックアップディレクトリの作成
BACKUP_DIR="/root/service_backup_$(date '+%Y%m%d_%H%M%S')"
mkdir -p "$BACKUP_DIR"

# 不要なサービスの無効化
log "不要なサービスを無効化しています..."
services_to_disable=(
    # "networkd-dispatcher.service"
    # "alsa-restore.service"
    # "avahi-daemon.service"
    # "console-setup.service"
)

for service in "${services_to_disable[@]}"; do
    if systemctl is-enabled "$service" &>/dev/null; then
        log "$service を無効化しています..."
        systemctl disable "$service" || error_log "$service の無効化に失敗しました"
    fi
done

# alsa-restore.service のマスク
# systemctl mask alsa-restore.service || error_log "alsa-restore.service のマスクに失敗しました"

# /etc/init.d/rc の設定
# 既存の設定をバックアップ
cp /etc/init.d/rc "$BACKUP_DIR/" || error_log "rc ファイルのバックアップに失敗しました"

# # CONCURRENCY が既に設定されているか確認
# if ! grep -q "^CONCURRENCY=shell" /etc/init.d/rc; then
#     echo "CONCURRENCY=shell" >> /etc/init.d/rc
# fi

# # extlinux.conf の設定
# if [ -f "/boot/extlinux/extlinux.conf" ]; then
#     # 既存の設定をバックアップ
#     cp /boot/extlinux/extlinux.conf "$BACKUP_DIR/" || error_log "extlinux.conf のバックアップに失敗しました"
    
#     if grep -q "^APPEND" /boot/extlinux/extlinux.conf; then
#         if ! grep -q "quiet splash" /boot/extlinux/extlinux.conf; then
#             sed -i '/^APPEND/ s/$/ quiet splash/' /boot/extlinux/extlinux.conf
#         fi
#     else
#         echo "APPEND quiet splash" >> /boot/extlinux/extlinux.conf
#     fi
# fi

# irqbalance のインストールと設定
log "irqbalance をインストールしています..."
apt update || error_log "apt update に失敗しました"
apt install -y irqbalance || error_log "irqbalance のインストールに失敗しました"
systemctl enable irqbalance.service || error_log "irqbalance の有効化に失敗しました"
systemctl start irqbalance.service || error_log "irqbalance の起動に失敗しました"

# configs直下のサービスファイルを処理
for service_file in "$CONFIG_DIR"/*"$SERVICE_EXT"; do
    if [ -f "$service_file" ]; then
        service_name=$(basename "$service_file")
        
        log "処理中: $service_name"
        
        # 既存のサービスファイルをバックアップ
        if [ -f "/etc/systemd/system/$service_name" ]; then
            cp "/etc/systemd/system/$service_name" "$BACKUP_DIR/" || error_log "$service_name のバックアップに失敗しました"
        fi
        
        # サービスファイルをシステムディレクトリにコピー
        cp "$service_file" /etc/systemd/system/ || error_log "$service_name のコピーに失敗しました"
        
        # パーミッションの設定
        chmod 644 "/etc/systemd/system/$service_name" || error_log "$service_name のパーミッション設定に失敗しました"
        
        # サービスを有効化
        # systemctl enable "$service_name" || error_log "$service_name の有効化に失敗しました"
        
        log "$service_name を登録しました"
    fi
done

# systemctl set-default multi-user.target || error_log "CUIモードの設定に失敗しました"

# systemdをリロード
systemctl daemon-reload || error_log "systemdのリロードに失敗しました"

log "すべての設定が完了しました。バックアップは $BACKUP_DIR に保存されています。"