<!--
title:  GitHub連携でQiitaの記事を素敵な執筆環境で！
tags:   qiita,markdown,github
-->

題名の「素敵な執筆環境」というのは、心地よいソファーだったり、甘えん坊の猫のことではなく、vim とか emacs とか vscode とかお気に入りのエディタを使ったの「執筆環境」を実現するために開発した python コマンドのお話です。

個人的には以下のような Qiita 公式の Web アプリによる執筆時の不満を解消するため、この執筆環境を開発しました。

- Web アプリという性質上、キーバインド由来の操作ミスが多くなり、個人的にイライラすることが多い。

- 図を更新の際に、Qiita のサイトに upload されたファイルを直接編集することはできず、図のファイルをローカルにコピーし、保存管理しておく必要がある。

- 等幅フォントで編集したい。

仕組みは簡単です。以下の図をご覧ください。

![Qiita_Sync_Overview](../img/qiita_sync.drawio.png)

_画像素材: <a href='https://pngtree.com/so/Man'>Man png from pngtree.com/</a> [^1]_

要するに、

1. Qiita の記事を vim で書いて、GitHub に push する。
2. GitHub Actions が自動で Qiita に記事を upload する。

これだけです。2. の GitHub Actions による自動化の方法を説明いたします。


[^1]: [link to illustration (pinterest)](https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fman-working-on-computer-at-home-isometric-vector_4000330.html?share=3&media=https://png.pngtree.com/png-vector/20190219/ourlarge/pngtree-man-working-on-computer-at-home-isometric-vector-png-image_321818.jpg&description=Man+working+on+computer+at+home+isometric+vector)
