<!--
title: pyenv + venv + poetry による開発環境構築 (Ubuntu 21.10)
tags:  python=3.6|3.7|3.8|3.9|3.10,ubuntu=21.10
id:    a5b5328c93bad615c5b2
-->

## pyenv

- 複数バージョンのpythonを切り替えて使えることができる。
- 各ユーザが使用するpythonのバージョンを切り替える。
- バージョンの切替はOSが使用しているpythonのバージョンに影響はない。
- venvを使って、開発環境毎にバージョンを切り替えられる。

### 1. python ビルドツールインストール

- pyenvはpythonをソースコードをダウンロードして、コンパイルして、開発者のhomeディレクトリにインストールする。
- そのためビルドツールをあらかじめインストールする必要がある。

:::note warn
各OSの必要パッケージは <a href="https://github.com/pyenv/pyenv/wiki#suggested-build-environment">Suggested build environment</a> を参照
:::

```shell:【参考】ubuntu-21.10
sudo apt-get update; sudo apt-get install make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```

### 2. pyenv インストール

- pyenvは[Shim](https://en.wikipedia.org/wiki/Shim_(computing))と呼ばれる方式で複数バージョンのpythonを切り替える。
- shim版python (`~/.pyenv/bin/python`) が本物のpythonの切替を行う方式。
- 複数バージョンのpythonは`~/.pyenv`配下のディレクトリにインストールされる。
- `~/.pyenv`には、python のインタプリタと標準ライブラリのみインストールし、それ以外のライブラリについては、
  後述のvenvによって各開発環境下にインストールする（ようにすべき）。

```shell
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

### 3. pyenv 最適化

- pythonのshim方式によるruntime時の負担を最適化する。
- 下記コマンドは失敗してもpyenvは動作するのでエラーは無視してよい。

```shell
cd ~/.pyenv && src/configure && make -C src
```

### 4. pyenv ユーザ環境設定

- pyenv用のPATHや各種環境変数を各ユーザが設定する必要がある。
- bashの場合、スクリプト用の設定と、ログインシェル用の設定を分けている。
- 設定完了後は、logoutとloginで設定変更を反映させる。

:::note warn
各OSの設定方法は <a href="https://github.com/pyenv/pyenv#basic-github-checkout">Basic GitHub Checkout</a> を参照
:::

```shell:【参考】ログインシェル用追加設定（.profile、.bash_profileなど）
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# shim版python 用 PATH の設定
eval "$(pyenv init --path)"
```

```shell:【参考】スクリプト用追加設定（.bashrcなど）
# 関数 pyenv の設定
eval "$(${HOME}/.pyenv/bin/pyenv init -)"
```

## venv

- python (3.4以降) 標準の仮想環境。
- 開発環境毎のpythonのruntime環境の切替、追加ライブラリの管理を行う。
- 標準ではあるが、runtime環境ではないのでOSによっては追加でインストールする必要がある。

```shell:ubuntu-21.10
sudo apt-get update; sudo apt install python3.9-venv
```

## poetry

- pythonのパッケージ管理ツール。
- 選択肢はたくさんあるが、現時点のbest practiseの模様。
- poetryは`~/.local/bin`にインストールされる。

:::note alert
pyenvで切り替えたpythonで実行しない
:::

```shell:ubuntu-21.10
curl -sSL https://install.python-poetry.org | python3 -
```

`~/.local/bin`がPATHに含まれていない場合は追加。
ubuntu 21.10ではデフォルトで含まれている。

```shell:【参考】ログインシェル用追加設定（.profile、.bash_profileなど）
export PATH="$HOME/.local/bin:$PATH"
```
