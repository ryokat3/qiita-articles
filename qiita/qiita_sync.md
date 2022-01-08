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
3. "Desciption" は適当な説明を入力。
4. "Scopes" の "read_qiita" と "write_qiita" をチェック（下図）
5. "Generate token" をクリック
6. 生成された Access Token はコピーして保存しておく

![Qiita Access Token 生成画面](../img/generate_qiita_access_token.png)

### Qiita Access Token の登録

Qiita 同期をする GitHub の repository を一つ用意する。できれば専用の repository を
用意することをお勧めします。

1. GitHub repository の GUI から Settings >> Secrets で "Actions secrets" の画面を表示
2. 右上の "New repository secret" のボタンをクリック
3. Name には `QIITA_ACCESS_TOKEN` と入力
4. Value には Qiita で生成した Access Token を入力（下図）
5. "Add secret"をクリックして登録完了

![GitHub Access Token 登録画面](../img/github_save_access_token.png)

### GitHub Actions の設定

以下の２つの YAML ファイルを作成する。

- `.github/workflows/qiita_sync_check.yml`
- `.github/workflows/qiita_sync.yml`

特に変更の必要はないが `qiita_sync_check.yml` の `cron: "29 17 * * *"` は変更して欲しい。
Qiita の記事の同期をチェックする GitHub Actions を cron で定期的に動かすのだが、利用者全員が
同じ時間を設定すると、GitHub にも Qiita にも一斉に負担がかかるので、それを避けるため設定の
変更をお願いしたい。

::: warn
cron の設定は変更する
:::

下記の例は 17:29 UTC なので日本時間だと毎日 02:29 JST に起動することになる。
もちろん一週間に一度に設定でも、毎時間起動しても構わない。


```yaml:.github/workflows/qiita_sync_check.yml
name: Qiita Sync Check

on:
  schedule:
    - cron: "29 17 * * *"
  workflow_run:
    workflows: ["Qiita Sync"]
    types:
      - completed
  workflow_dispatch:

jobs:
  qiita_sync_check:
    name: qiita-sync check
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install qiita-sync
        run: |
          curl -OL https://raw.githubusercontent.com/ryokat3/qiita-sync/v1.0.0/qiita_sync/qiita_sync.py
      - name: Run qiita-sync check
        run: |
          python qiita_sync.py check . > ./qiita_sync_output.txt
          cat ./qiita_sync_output.txt
          [ ! -s "qiita_sync_output.txt" ] || exit 1
        env: 
          QIITA_ACCESS_TOKEN: ${{ secrets.QIITA_ACCESS_TOKEN }}
```


```yaml:.github/workflows/qiita_sync.yml
name: Qiita Sync

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  qiita_sync_check:
    name: Run qiita-sync sync
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: '3.9'
      - name: Install qiita-sync
        run: |
          curl -OL https://raw.githubusercontent.com/ryokat3/qiita-sync/v1.0.0/qiita_sync/qiita_sync.py
      - name: Run qiita-sync
        run: |
          python qiita_sync.py sync .
        env: 
          QIITA_ACCESS_TOKEN: ${{ secrets.QIITA_ACCESS_TOKEN }}
      - name: Git
        run: |
          find . -name '*.md' -not -path './.*' | xargs git add
          if ! git diff --staged --exit-code --quiet
          then
            git config user.name github-actions
            git config user.email github-actions@github.com
            find . -name '*.md' -not -path './.*' | xargs git add
            git commit -m "updated by qiita-sync"
            git push
          fi
```




## 参照

[^1]: [画像素材](https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fman-working-on-computer-at-home-isometric-vector_4000330.html?share=3&media=https://png.pngtree.com/png-vector/20190219/ourlarge/pngtree-man-working-on-computer-at-home-isometric-vector-png-image_321818.jpg&description=Man+working+on+computer+at+home+isometric+vector) の一部は [Man png from pngtree.com/](https://pngtree.com/so/Man) のものを使用しています。