# これは何？

[glean](https://github.com/glean/glean) にかわって、コンフィギュレーションなどをうまいこと管理してくれるものです。

glean のように特定のリモートリポジトリを主と期待してローカルにキャッシュを構築するのではなく、ローカルに構築されたデータベースを主として扱います (`glean search` のようなリモートの情報を正とした動作はしません)。

# やりたいこと

構成管理ツールに載らないコンフィギュレーションの管理を Excel やスプレッドシートからはがしたい。
メタ情報の管理をする土台を Git にのせて、かつ、共有可能にする。
そうすると、Pull request ベースでの設定変更依頼が出せるようになる。
このツールは、その土台となるビューワーを提供する。

# なにができるの？

データベースの構築。

    mkdir $HOME/.yet_another_glean
    cd $HOME/.yet_another_glean
    git clone git@github.com:bm-sms/glean-daimon-lunch.git daimon-lunch

ローカルのパス (`$HOME/.yet_another_glean`) にあるデータベース群から必要な項目を検索して表示します。

    ygl switch daimon-lunch # データベースの選択
    ygl show oosaka #=> to show https://github.com/bm-sms/glean-daimon-lunch/blob/master/oosaka.toml
    ygl show --format=yaml oosaka # show in yaml format
    ygl show --format=json oosaka # show in json format
    ygl current #=> daimon-lunch 今いるデータベースの名前の表示
    ygl show-all #=> show all data in daimon-lunch (like glean does)
    ygl show-all --format=yaml
    ygl show-all --format=json

# やらないこと

ツールとしてはファイルパスをベースにした対象のピックアップまでをスコープとし、データ内容にたいする汎用的でリッチな検索は、このツールの外で提供するものとして対応しません。

# 進め方

1. まず、この CLI ツールで必要なライブラリからつくりましょう。どんな役割の部品があれば、ツールがつくれるでしょう？
1. つくった部品を組み合わせて、CLI から呼び出しましょう。Thor を使って CLI を開発してみてください。

