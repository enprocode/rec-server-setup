#!/bin/bash

# EPGStation をインストール・初期設定し、pm2 で起動する。
# 先に mirakurun-install.sh を実行し Mirakurun を用意しておくこと。

echo "EPGStation install and setup start!"
cd ~/ || exit
git clone https://github.com/l3tnun/EPGStation.git
cd EPGStation || exit
npm run all-install
npm run build

# Cretate configure file
cp config/operatorLogConfig.sample.yml config/operatorLogConfig.yml
cp config/epgUpdaterLogConfig.sample.yml config/epgUpdaterLogConfig.yml
cp config/serviceLogConfig.sample.yml config/serviceLogConfig.yml
cp config/enc.js.template config/enc.js
cp ~/mirakurun-epgstation-install/conf/config.yml config/config.yml
cp -r ~/mirakurun-epgstation-install/bin/ .

# EPGStation start and enabled
sudo pm2 start dist/index.js --name "epgstation"
sudo pm2 save
echo "EPGStation install and setup done!"
