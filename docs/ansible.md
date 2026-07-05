# rec-server-script-dev
録画サーバー構築スクリプト(Dev)

## Usage / 使用方法
```(bash)
$ cd ansible

# Dry-run
$ sudo ansible-playbook -i hosts rec-ubuntu-provisioning.yml -vvv --check

# Run
$ sudo ansible-playbook -i hosts rec-ubuntu-provisioning.yml -vvv
```

## コードについて
- サーバー構築を自動化する目的で作られています。
- 自分の環境用に合わせていますので、適宜変更お願いします。

## 各種ライブラリ & ソース元

| Name | URL |
| ---- | ---- |
| px4_drv | https://github.com/nns779/px4_drv |
| libaribb25 | https://github.com/tsukumijima/libaribb25 |
| recpt1 | https://github.com/stz2012/recpt1 |
| Mirakurun | https://github.com/Chinachu/Mirakurun |
| EPGStation | https://github.com/l3tnun/EPGStation |


## 実行環境
- OS: Ubuntu Server 20.04
- [ansible](https://www.ansible.com)