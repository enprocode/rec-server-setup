#!/bin/bash

# Mirakurun をインストールし、対話メニューでチューナー設定を選択する。
# チューナー選択は運用スクリプト mirakurun-config.sh に一本化している。
# ../conf を参照するため native-install/shell ディレクトリ内で実行すること。

cd "$(dirname "$0")" || exit

echo "Mirakurun install start!"
sudo npm install arib-b25-stream-test -g --unsafe-perm
sudo npm install pm2 -g
sudo npm install mirakurun -g --production
sudo mirakurun init

# チューナー設定 (tuners.yml) の選択・反映
bash mirakurun-config.sh

echo "Mirakurun install done!"
