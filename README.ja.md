Keg [![Circle CI](https://circleci.com/gh/bm-sms/keg.svg?style=svg&circle-token=64f349201f5cb44f1ac47b1172626522253d20ec)](https://circleci.com/gh/bm-sms/keg)
====

Kegは、データ管理支援を目的としたCLIツールです。

## Description
Kegが扱うデータは、[TOML](https://github.com/toml-lang/toml)と呼ばれる可読性の高い形式で書かれたデータです。
Kegは、ローカルに構築されたデータベース内にあるTOML形式のファイルを読み込み、利用しやすい形式にして出力します。  
事前に、利用したいTOMLファイルがあるリポジトリをローカルのデータベース(`$HOME/.keg/databases`)にクローンする必要があります。

## VS. [glean](https://github.com/glean/glean)
gleanは特定のリモートリポジトリからローカルにキャッシュを構築しているのに対し、Kegはローカルに構築されたデータベースを主として扱います。
そのため、リポジトリの更新があった場合は手動でpullする必要があります。しかし、ローカルのデータを扱うため高速に動作します。

## Requirements
Ruby 2.0 以上


## Installation

Gemfileに追加する場合 :

```sh
gem 'keg'
```

手動でインストールする場合 :

```sh
$ gem install keg
```

## Usage
### 準備:
TOMLファイルの作成 :

```toml
# example.toml
name = 'example'
email = 'example@example.com'
```

作成したTOMLファイルをgitにpush :

```sh
$ git add example.toml
$ git commit -m 'add keg example'
$ git push origin master
```

データベースの構築 :

```sh
$ mkdir -p $HOME/.keg/databases
$ cd $HOME/.keg/databases
$ git clone <your_repo> example_database
```

### デモ:

ローカルのパス(`$HOME/.keg/databases`)内のデータベース群からデータベースを選択する :

```sh
$ keg switch example_database   #=> switch database `example_database`
```

データベース内にある要求されたTOMLファイルをフォーマットして表示する :

```sh
$ keg show example               # show $HOME/.keg/databases/example_database/example.toml
$ keg show --format=json example # show in json format
$ keg show --format=yaml example # show in yaml format
```

現在選択されているデータベース名を表示する :

```sh
$ keg current                    #=> example_database
```

選択されているデータベース内の全てのTOMLファイルをフォーマットして表示する :

```sh
$ keg show_all                  # show all TOML in example_database
$ keg show_all --format=json    # show all in json format
$ keg show_all --format=yaml    # show all in yaml format
```

## Contributing
バグレポートとプルリクエストは https://github.com/bm-sms/keg にてお待ちしております。コントリビューアは [Contributor Covenant](http://contributor-covenant.org) に殉ずる事をお願いします。

## License
このgemは[MIT License](http://opensource.org/licenses/MIT)の元で利用可能です。
