# docker (mirack-epgstation-px4)

mirakc + EPGStation + MySQL を Docker で構築する方式です。
ホスト側にはチューナードライバのみ必要で、Mirakurun/EPGStation 本体はコンテナで動作します。

## 前提
- ホストにチューナードライバ (px4_drv など) がインストール済みであること … [drivers.md](drivers.md) を参照
- Docker / Docker Compose がインストール済みであること

## Usage / 使用方法

```bash
cd docker/setup
bash setup.sh
```

`setup.sh` は EPGStation の設定を配置し、`docker-compose up -d` でコンテナ群(mirakc / EPGStation / MySQL)を起動します。

## 構成
| ディレクトリ | 内容 |
| ---- | ---- |
| `docker/setup/` | `setup.sh`・`docker-compose.yml`・`config.yml`(起動用) |
| `docker/docker/mirakc/` | mirakc の設定・初期化スクリプト |
| `docker/docker/epgstation/` | EPGStation の設定 |
| `docker/docker/debian/` | mirakc イメージ用 Dockerfile |

## 動作について
Ubuntu Server 20.04 にて動作確認済みです。自分の環境に合わせて適宜変更してください。
