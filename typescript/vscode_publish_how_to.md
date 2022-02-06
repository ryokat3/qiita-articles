<!--
title:  【初心者向け】VSCode拡張をMarketPlaceに公開するまで ～公式手順は茨の道なのか？～
tags:    Typescript,vscode,初心者,個人開発
-->

初めて VScode の拡張 plugin （下記のリンク）を作成しました。公式の [Marketplaceの公開手順](https://code.visualstudio.com/api/working-with-extensions/publishing-extension) を見る限りでは、[PyPI](https://pypi.org) や [npm](https://www.npmjs.com) でパッケージを公開するぐらいに簡単そうです。

https://marketplace.visualstudio.com/items?itemName=ryokat3.vscode-qiita-markdown-preview

ですが、**とんでもなく上手くい行きません**でした。顛末記を記したこの記事が、これから plugin 作るぞ、という方の参考になれば幸いです。

この記事の内容は以下のようになります。

:::note info
1. Typescript による VSCode 拡張の作成
2. MarketPlace 向けパッケージの作成
3. MarketPlace でのパッケージの公開
:::

開発環境は、

- OS: Ubuntu 21.10
- Nodejs: v16.13.2
- Typescript: 4.5.4
- Webpack: 5.68.0

取り合えず現時点(2022年2月初旬)の最新版という感じです。

# Typescript による VSCode 拡張の作成

## 開発基盤のテンプレートの作成

公式手順の [Your First Extension](https://code.visualstudio.com/api/get-started/your-first-extension)に従っていれば大丈夫です。あっという間にできあがります。

## 開発

### npm,  yarn どっちを使う？

さていよいよ開発なのですが、node module のインストールでの掟です。

:::note warn
npm は使うな、yarn を使え
:::

私も今回初めて yarn というツールを知りました。npm の代わりに module の install/update などを行ってくれます。理由は[このissue](https://github.com/microsoft/vscode-vsce/issues/432)が関係しているように思えます。**npm を使うとパッケージが後で上手く作成できません**。npm を使うと `package-lock.json`というファイルが作成されますが、このファイルの形式（内容？）の変更後問題が発生しているらしいです。代わりに yarn は `yarn.lock` というファイルを作成します。こちらはオーケーみたいです。

### webpack

:::note warn
できれば webpack を使いましょう
:::

webpack は必須ではないものの、使わないと **node_modules 配下の全モジュールをパッケージに含める** ことになります。全部入りはさすがにファイルサイズがでかいです。プラグイン実行時には必要のない開発用、テスト用 module も全部含まれてしまいます。

それでも動きますが、この事実を一度知ってしまうと、俺のプログラムイケてない感に悩ませられ続けます。

いつの頃からか webpack の config も Typescript で書けるようになり、無茶苦茶便利になりました。拡張子を `.ts` にするだけです。変数の簡単な説明が、型ヒントのポップアップで簡単に見えるようになるので、いちいちググらなくて良くなります。Webpack 5 からは型定義ファイルもインストールしなくて良くなりました。

### Typescript

拡張 plugin の作成には VSCode API を作成する