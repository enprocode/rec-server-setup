#!/bin/bash

# Mirakurun と EPGStation をまとめてインストールするスクリプト。
# 実体は同ディレクトリの2本を順に呼び出すだけ。

cd "$(dirname "$0")" || exit

bash mirakurun-install.sh
bash epgstion-install.sh
