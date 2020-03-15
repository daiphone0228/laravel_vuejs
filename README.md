# laravel_vuejs

## Introduction

本リポジトリは、Laravel + vue.jsの環境でいじいじするものです。
基本作りかけな感じになりますが、ご容赦ください。
git cloneしてきた時点で"project/"配下にあるLaravelプロジェクトは、[GitHub](https://github.com/laravel/laravel)からcloneしたものになります。
ご自身のプロジェクトを利用する場合は、"project/"配下を置き換えてください。

## 構築環境

AmazonLinux2

Laravel

Vue.js

## 想定ディレクトリ構成

```
laravel_amazonlinux2/
├── README.md
├── docker
│   ├── app
│   ├── db
│   └── docker-compose.yml
└── project
    └── laravel
```

## 事前準備

環境変数を.envファイルにまとめて、そちらを参照する形式となります。

ご自身の環境に応じて変更してください。

```shell
# .envファイル作成
$ cd docker
$ cp .env.example .env
```

## 構築手順

### .envファイルの値を変更する

.envファイルを自身の環境に合わせて変更してください。

```shell
$ vi .env

ENV_DOCUMENT_ROOT # ドキュメントルートを指定　
ENV_SRC_DIRECTORY_NAME # 展開するlaravelプロジェクトのディレクトリ名を指定
ENV_DB_CONNECTION # laravelで指定しているDB_CONNECTIONの値を指定
ENV_DB_HOST # DBのホスト名を指定（Local環境のDockerの場合、コンテナ名を指定）
ENV_DB_PORT # 任意のDBポートを指定
ENV_DB_DATABASE # データベース名を指定
ENV_DB_USERNAME # データベースログイン用のユーザー名を指定
ENV_DB_PASSWORD # データベースログイン用のパスワードを指定
ENV_DB_ROOT_PASSWORD # rootアカウントのパスワードを指定
ENV_APP_PORT # 任意のApplicationポートを指定

※その他追加したい環境変数はこちらに記入

```

### Docker-composeを実行


```shell
$ docker-compose up -d --build
Building db
Step 1/1 : FROM mariadb:10.4
10.4: Pulling from library/mariadb
5c939e3a4d10: Pulling fs layer
c63719cdbe7a: Pulling fs layer
...
Building app
Step 1/43 : FROM amazonlinux:2
2: Pulling from library/amazonlinux
...
Successfully built f4512dcc882a
Successfully tagged laravel:latest
Recreating laravel_mariadb ... done
Recreating laravel         ... done
```

### コンテナ起動確認

Dockerコンテナが正常に起動しているか確認します。

```shell
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
c057c7c0a12a        laravel             "/etc/entrypoint.sh"     35 minutes ago      Up 35 minutes       0.0.0.0:8080->80/tcp     laravel
18a9d53b8abf        laravel_mariadb     "docker-entrypoint.s…"   36 minutes ago      Up 35 minutes       0.0.0.0:3306->3306/tcp   laravel_mariadb

```

※もしこの時点で、`STATUS`の値がRestarting...等の場合、構築に失敗しています。編集箇所を確認してみてください。

### コンテナ初期設定

#### laravelコンテナにログイン

```shell
$ docker exec -it laravel /bin/bash
```

#### プロジェクトルートにいるか確認

```shell
bash-4.2# pwd
/work/laravel
```

#### composer install

```shell
bash-4.2# composer install
Loading composer repositories with package information
Updating dependencies (including require-dev)
Package operations: 86 installs, 0 updates, 0 removals
  - Installing symfony/polyfill-ctype (v1.13.1): Downloading (100%)
  - Installing phpoption/phpoption (1.7.2): Downloading (100%)
  ...
Discovered Package: nunomaduro/collision
Package manifest generated successfully.
```

#### laravel 初期設定

```shell
bash-4.2# php artisan key:generate
Application key set successfully.

bash-4.2# php artisan config:clear
Configuration cache cleared!

bash-4.2# php artisan migrate
Migration table created successfully.
Migrating: 2014_10_12_000000_create_users_table
Migrated:  2014_10_12_000000_create_users_table (0.04 seconds)
Migrating: 2014_10_12_100000_create_password_resets_table
Migrated:  2014_10_12_100000_create_password_resets_table (0.02 seconds)
Migrating: 2019_08_19_000000_create_failed_jobs_table
Migrated:  2019_08_19_000000_create_failed_jobs_table (0.01 seconds)

bash-4.2# php artisan db:seed
Database seeding completed successfully.
```

#### npm install

```shell
bash-4.2# npm install
[         .........] - extract:@babel/plugin-proposal-unicode-property-regex: http fetch GET 200 https://registry.npmjs.org/regexpu-core/-/regexpu-core-4.6.0.tgz 590ms
added 1051 packages from 486 contributors and audited 17273 packages in 91.995s

31 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```

#### プログラムをビルド

```shell
bash-4.2# npm run dev
 DONE  Compiled successfully in 8287ms

       Asset     Size   Chunks             Chunk Names
/css/app.css  0 bytes  /js/app  [emitted]  /js/app
  /js/app.js  592 KiB  /js/app  [emitted]  /js/app

```

### 動作確認

http://localhost:8080/ にアクセスしてLaravelのTOPページが出てきたら成功





