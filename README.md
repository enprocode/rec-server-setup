# rec-server-setup

[![CI](https://github.com/enprocode/rec-server-setup/actions/workflows/ci.yml/badge.svg)](https://github.com/enprocode/rec-server-setup/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/enprocode/rec-server-setup)](https://github.com/enprocode/rec-server-setup/releases)
[![License: MIT](https://img.shields.io/github/license/enprocode/rec-server-setup)](LICENSE)

録画サーバー(TV録画サーバー)を構築するためのスクリプト・設定を1つに集約したリポジトリです。
チューナードライバのインストールから Mirakurun / mirakc + EPGStation の構築まで、複数の方式をまとめて管理します。

もともと以下の4リポジトリに分かれていたものを、**構築方式ごと**に整理して集約しています。
各方式の詳細ドキュメントは [`docs/`](docs/) にまとめています。

| ディレクトリ | 旧リポジトリ | 役割 | ドキュメント |
| ---- | ---- | ---- | ---- |
| [`drivers/`](drivers/) | rec-cmd-install | チューナードライバ・録画コマンド (px4_drv / recpt1 / libaribb25) のインストール(全方式共通) | [docs/drivers.md](docs/drivers.md) |
| [`native-install/`](native-install/) | mirakurun-epgstation-install | Mirakurun + EPGStation をネイティブ(直接)インストールするシェルスクリプト & 設定 | [docs/native-install.md](docs/native-install.md) |
| [`ansible/`](ansible/) | rec-server-script-dev | 上記を Ansible でまとめて自動構築(ネイティブ方式の自動化) | [docs/ansible.md](docs/ansible.md) |
| [`docker/`](docker/) | mirakc-epgstation-px-x1ud | mirakc + EPGStation + MySQL を Docker で構築(Docker方式) | [docs/docker.md](docs/docker.md) |

## 構築方式の選び方

録画サーバーの構築には大きく2系統あります。用途に応じて選択してください。手順の詳細はいずれも [`docs/`](docs/) を参照してください。

- **A. ネイティブ / Ansible 方式** … ホスト上に直接インストール。手動なら `drivers/` → `native-install/` の順にスクリプトを実行、一括自動構築なら `ansible/` の Playbook を実行します。([docs/drivers.md](docs/drivers.md) / [docs/native-install.md](docs/native-install.md) / [docs/ansible.md](docs/ansible.md))
- **B. Docker 方式** … mirakc + EPGStation + MySQL をコンテナで構築。ホストにはドライバのみ必要です。([docs/drivers.md](docs/drivers.md) / [docs/docker.md](docs/docker.md))

## 動作確認環境
- OS: Ubuntu Server 20.04

## 各種ライブラリ & ソース元

| Name | URL |
| ---- | ---- |
| px4_drv | https://github.com/nns779/px4_drv |
| libaribb25 | https://github.com/tsukumijima/libaribb25 |
| recpt1 | https://github.com/stz2012/recpt1 |
| Mirakurun | https://github.com/Chinachu/Mirakurun |
| mirakc | https://github.com/mirakc/mirakc |
| EPGStation | https://github.com/l3tnun/EPGStation |

## バージョン管理 / リリース
- バージョンはルートの [`VERSION`](VERSION) ファイルで管理します。
- `VERSION` を更新して `main` に push すると、[GitHub Actions](.github/workflows/release.yml) が `v<バージョン>` タグと GitHub Release(リリースノート自動生成)を作成します。
- リリース手順: `VERSION` を書き換える → コミット → `main` へ反映。

## 開発 / 自動化
- **Dependabot** ([`.github/dependabot.yml`](.github/dependabot.yml)): GitHub Actions と mirakc 用 Dockerfile のベースイメージを毎週チェックします。
- **Mergify** ([`.github/mergify.yml`](.github/mergify.yml)): Dependabot の PR をコンフリクトが無ければ自動マージします。マージ後のブランチ削除は GitHub の「Automatically delete head branches」設定に任せます。

## ライセンス
[MIT License](LICENSE) の下で公開しています。なお各ドライバ・ソフトウェア本体(`px4_drv` / `recpt1` / `Mirakurun` / `mirakc` / `EPGStation` など)は、それぞれの上流リポジトリのライセンスに従います。

## メモ
- `ansible/` の各ロール(`roles/rec_cmd`, `roles/mirakurun`)は、集約済みの `drivers/` / `native-install/` を直接参照します(`playbook_dir` からの相対パス)。旧リポジトリの `git clone` は不要です。なお、チューナードライバ本体(`px4_drv` / `libaribb25` / `recpt1`)のソースは各インストールスクリプト内で上流から `git clone` されます。
- `.gitignore` は各ディレクトリに個別のものを残しつつ、ルートにも共通パターンを集約した `.gitignore` を用意しています。
