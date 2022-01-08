<!--
title:  GitHub連携でQiitaを素敵な執筆環境で！
tags:   qiita,markdown,github
-->

題名の「素敵な執筆環境」というのは、心地よいソファーだったり、甘えん坊の猫のことではなく、vim とか emacs とか vscode とかお気に入りのエディタを使ったの「執筆環境」を実現するために開発した python コマンドのお話です。

個人的には以下のような Qiita 公式の Web アプリによる執筆時の不満を解消するため、この執筆環境を開発しました。

- Web アプリという性質上、キーバインド由来の操作ミスが多くなり、個人的にイライラすることが多い。

- 図を更新の際に、Qiita のサイトに upload されたファイルを直接編集することはできず、図のファイルをローカルにコピーし、保存管理しておく必要がある。

- 等幅フォントで編集したい。

仕組みは簡単です。以下の図をご覧ください。


![Qiita Sync](../img/qiita_sync.drawio.png)

_<font size="2">画像素材: <a href='https://pngtree.com/so/Man'>Man png from pngtree.com/</a></font>[^1]_


要するに、

1. Qiita の記事を vim で書いて、GitHub に push する。
2. GitHub Actions が自動で Qiita に記事を upload する。

これだけです。2. の GitHub Actions による自動化の方法を説明いたします。

## 準備

### Qiita Access Token の生成

記事の投稿に [Qiita API v2](https://qiita.com/api/v2/docs) を使うので
秘密鍵である Access Token が必要になります。Access Token は Qiita の
ユーザ画面から、

1. [Qiita Account Applications](https://qiita.com/settings/applications) を開く
2. "Generate new token" をクリック
3. "Desciption" に `QIITA_ACCESS_TOKEN` と入力
4. "Scopes" の "read_qiita" と "write_qiita" をチェック（下図）
5. "Generate token" をクリック

![Qiita Access Token 生成画面](../img/generate_qiita_access_token.png)



## 参照

[^1]: [link to illustration (pinterest)](https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fman-working-on-computer-at-home-isometric-vector_4000330.html?share=3&media=https://png.pngtree.com/png-vector/20190219/ourlarge/pngtree-man-working-on-computer-at-home-isometric-vector-png-image_321818.jpg&description=Man+working+on+computer+at+home+isometric+vector)

