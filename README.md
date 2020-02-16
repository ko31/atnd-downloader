# ATND Downloader

[ATND API](https://api.atnd.org) から管理しているイベント、参加ユーザー情報をダウンロードするスクリプトです。

ATND が[2020年4月14日にサービス終了](https://api.atnd.org/doc/atnd_notice_20200114.pdf)してしまうため😥、過去データを残しておくために作ったものです。

## 必要なもの

下記のコマンドが必要になります。

- [curl](https://curl.haxx.se/)
- [jq](https://stedolan.github.io/jq/)

## 使い方

事前に自分のオーナーIDを確認しておいてください。
（ATND にログイン後、マイページの URL からオーナー ID が分かります。）

```
# オーナーIDは 129340
https://atnd.org/users/129340
```

コンソールで下記コマンドを実行します。最後の `[オーナーID]` は自分のオーナー ID に置き換えてください。

```
curl -L https://raw.githubusercontent.com/ko31/atnd-downloader/master/get.sh | bash -s -- [オーナーID]
```

`json` ディレクトリに次の json ファイルが保存されます。

- `events.json`
  - イベントサーチ API から取得したイベント情報
- `users_[event_id].json`
  - 出欠確認 API から取得した各イベントの参加ユーザー情報

## 注意事項

- イベントは最大100件まで取得されます。
- 2020年4月14日を過ぎたらたぶん動作しなくなると思います。
