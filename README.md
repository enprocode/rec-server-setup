# rec-server

録画サーバー(TV録画サーバー)を構築するためのスクリプト・設定を1つに集約したリポジトリです。
チューナードライバのインストールから Mirakurun / mirakc + EPGStation の構築まで、複数の方式をまとめて管理します。

もともと以下の4リポジトリに分かれていたものを、**構築方式ごと**に整理して集約しています。
各方式の詳細ドキュメントは [`docs/`](docs/) にまとめています。

| ディレクトリ | 旧リポジトリ | 役割 | ドキュメント |
| ---- | ---- | ---- | ---- |
| [`drivers/`](drivers/) | rec-cmd-install | チューナードライバ・録画コマンド (px4_drv / recpt1 / libaribb25) のインストール(全方式共通) | [docs/drivers.md](docs/drivers.md) |
| [`native-install/`](native-install/) | mirakurun-epgstation-install | Mirakurun + EPGStation をネイティブ(直接)インストールするシェルスクリプト & 設定 | [docs/native-install.md](docs/native-install.md) |
| [`ansible/`](ansible/) | rec-server-script-dev | 上記を Ansible でまとめて自動構築(ネイティブ方式の自動化) | [docs/ansible.md](docs/ansible.md) |
| [`docker/`](docker/) | mirack-epgstation-px4 | mirakc + EPGStation + MySQL を Docker で構築(Docker方式) | [docs/docker.md](docs/docker.md) |

## 構築方式の選び方

録画サーバーの構築には大きく2系統あります。用途に応じて選択してください。

### A. ネイティブ / Ansible 方式
ホスト上に直接インストールする方式。まず `drivers/` でドライバを入れ、続けて Mirakurun + EPGStation を構築します。

- **手動で構築する場合** … `drivers/` → `native-install/` の順にスクリプトを実行
- **一括自動構築する場合** … `ansible/` の Playbook を実行(内部で apt / node / mysql / ドライバ / Mirakurun / EPGStation を順に構成)

```bash
# Ansible による自動構築
cd ansible
# Dry-run
sudo ansible-playbook -i hosts rec-ubuntu-provisioning.yml -vvv --check
# 実行
sudo ansible-playbook -i hosts rec-ubuntu-provisioning.yml -vvv
```

### B. Docker 方式
mirakc + EPGStation + MySQL をコンテナで構築する方式。ホストにはドライバのみ必要です。

```bash
# ドライバは drivers/ で先にインストールしておく
cd docker/setup
bash setup.sh
```

各方式の詳細な使い方は [`docs/`](docs/) 配下のドキュメントを参照してください。

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
- **Mergify** ([`.github/mergify.yml`](.github/mergify.yml)): Dependabot の PR をコンフリクトが無ければ自動マージし、マージ後にブランチを削除します。

## ライセンス
[MIT License](LICENSE) の下で公開しています。なお各ドライバ・ソフトウェア本体(`px4_drv` / `recpt1` / `Mirakurun` / `mirakc` / `EPGStation` など)は、それぞれの上流リポジトリのライセンスに従います。

## メモ / 今後の整理候補
- `ansible/` の各ロール(`roles/rec_cmd`, `roles/mirakurun`)は、集約済みの `drivers/` / `native-install/` を直接参照します(`playbook_dir` からの相対パス)。旧リポジトリの `git clone` は不要です。なお、チューナードライバ本体(`px4_drv` / `libaribb25` / `recpt1`)のソースは各インストールスクリプト内で上流から `git clone` されます。
- `.gitignore` は各ディレクトリに残しています。リポジトリ全体を git 管理する際は、ルートに統合した `.gitignore` を用意すると管理しやすくなります。
