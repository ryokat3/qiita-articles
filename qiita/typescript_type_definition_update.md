<!--
title: TypeScriptの型定義ファイルをnpmパッケージとして追加する
tags:  GitHub,npm,TypeScript
id:    69d248e42ebccb0b125b
-->
1. DefinitelyTypedをforkする
  - forkすると自分のアカウントにDefinitelyTypedのrepositoryができる

2. forkしたrepositoryをcloneする
　- 全型定義ファイルがlocal diskにダウンロードされるのでdisk容量に注意

3. `git checkout -b pretty-data`

4. 定義ファイル追加

5. git add pretty-data

6. git commit -m 'Added pretty-data Typescript declaration'

7. git push origin pretty-data

8. `Compare & pull request` click!

9. Pull requestが追加される

![Capture.PNG](https://qiita-image-store.s3.amazonaws.com/0/115148/80b81074-e873-2fd2-d0f2-dbfd110a640c.png)
