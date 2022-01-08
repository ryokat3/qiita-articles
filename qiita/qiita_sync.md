<!--
title:  GitHub連携でQiita記事を素敵な執筆環境で！
tags:   qiita,markdown,github
-->

## 「素敵な執筆環境」とは？

心地よいソファーだったり、甘えん坊だけどキーボードの上だけは避けてくれる猫のことではなく、vi とか emacs とか vscode とか、お気に入りのエディタを使った執筆環境を実現するために開発した Qiita Sync の紹介です。

### Qiita の記事を執筆する時の不満

個人的には以下のような Qiita 公式の Web アプリによる執筆時の不満を解消するため、この執筆環境を開発しました。

- Web アプリという性質上、マウスの多用を強制されたり、慣れたエディタのキーバインドが操作ミスになったり（Backspace 代わりの Ctrl-H で履歴画面を見せられる...）、個人的にイライラすることが多い。

- 図を更新の際に、Qiita のサイトに upload されたファイルを直接編集することはできず、図のファイルをローカルにコピーし、保存管理しておく必要がある。

- Markdown の Table は等幅フォントで編集したい。

### vi で記事を書いて GitHub に push するだけ

あとは Qiita Sync にお任せです。

1. Qiita の記事を vim で書いて、GitHub に push 
2. GitHub Actions が自動で Qiita に記事を upload （下図）

![Qiita Sync](../img/qiita_sync.drawio.png) [^1]


### 記事の同期も自動でチェック

Qiitaの記事をブラウザでチャチャっと作ったり、更新したり、そんな時は GitHub との
同期が取れなくなることもあります。でも大丈夫、同期がとれないことは、GitHub の画面で確認できるし、
GitHub からメールのお知らせが届きます。

記事の差分が確認できたら、クリックひとつで再び同期させることもできます。

1. Qiita の記事をブラウザで更新
2. GitHub Actions が定期的に記事の同期をチェック
3. 同期が取れていれば GitHub の GUI に緑のバッジ、そうでなければ赤のバッジを表示
4. 同期が取れていない時は GitHub からメールで通知

![Qiita Sync Check](../img/qiita_sync_check.drawio.png) [^1]


### インストールしなくていい、使い方も覚えなくていい

メインの機能を提供する Qiita Sync は python の CLI コマンドですが、GitHub Actions 上で動作するので、
コマンドをインストールしたり、使い方や引数を覚えたりする必要はありません。
もちろん python のインストールも不要です。

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
6. 生成された Access Token はコピーして保存しておく

![Qiita Access Token 生成画面](../img/generate_qiita_access_token.png)




## 参照

[^1]: [画像素材](https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fman-working-on-computer-at-home-isometric-vector_4000330.html?share=3&media=https://png.pngtree.com/png-vector/20190219/ourlarge/pngtree-man-working-on-computer-at-home-isometric-vector-png-image_321818.jpg&description=Man+working+on+computer+at+home+isometric+vector) の一部は [Man png from pngtree.com/](https://pngtree.com/so/Man) のものを使用しています。