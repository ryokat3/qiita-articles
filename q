[1mdiff --git a/qiita/qiita_sync.md b/qiita/qiita_sync.md[m
[1mindex 7f19ade..01b6d26 100644[m
[1m--- a/qiita/qiita_sync.md[m
[1m+++ b/qiita/qiita_sync.md[m
[36m@@ -1,5 +1,5 @@[m
 <!--[m
[31m-title:  GitHub連携でQiitaの記事を素敵な執筆環境で！[m
[32m+[m[32mtitle:  GitHub連携でQiitaを素敵な執筆環境で！[m
 tags:   qiita,markdown,github[m
 -->[m
 [m
[36m@@ -15,9 +15,11 @@[m [mtags:   qiita,markdown,github[m
 [m
 仕組みは簡単です。以下の図をご覧ください。[m
 [m
[31m-![Qiita_Sync_Overview](../img/qiita_sync.drawio.png)[m
 [m
[31m-_画像素材: <a href='https://pngtree.com/so/Man'>Man png from pngtree.com/</a> [^1]_[m
[32m+[m[32m![Qiita Sync](../img/qiita_sync.drawio.png)[m
[32m+[m
[32m+[m[32m_<font size="2">画像素材: <a href='https://pngtree.com/so/Man'>Man png from pngtree.com/</a></font>[^1]_[m
[32m+[m
 [m
 要するに、[m
 [m
[36m@@ -26,5 +28,25 @@[m [m_画像素材: <a href='https://pngtree.com/so/Man'>Man png from pngtree.com/</a[m
 [m
 これだけです。2. の GitHub Actions による自動化の方法を説明いたします。[m
 [m
[32m+[m[32m## 準備[m
[32m+[m
[32m+[m[32m### Qiita Access Token の生成[m
[32m+[m
[32m+[m[32m記事の投稿に [Qiita API v2](https://qiita.com/api/v2/docs) を使うので[m
[32m+[m[32m秘密鍵である Access Token が必要になります。Access Token は Qiita の[m
[32m+[m[32mユーザ画面から、[m
[32m+[m
[32m+[m[32m1. [Qiita Account Applications](https://qiita.com/settings/applications) を開く[m
[32m+[m[32m2. "Generate new token" をクリック[m
[32m+[m[32m3. "Desciption" に `QIITA_ACCESS_TOKEN` と入力[m
[32m+[m[32m4. "Scopes" の "read_qiita" と "write_qiita" をチェック（下図）[m
[32m+[m[32m5. "Generate token" をクリック[m
[32m+[m
[32m+[m[32m![Qiita Access Token 生成画面](../img/generate_qiita_access_token.png)[m
[32m+[m
[32m+[m
[32m+[m
[32m+[m[32m## 参照[m
 [m
 [^1]: [link to illustration (pinterest)](https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fpngtree.com%2Ffreepng%2Fman-working-on-computer-at-home-isometric-vector_4000330.html?share=3&media=https://png.pngtree.com/png-vector/20190219/ourlarge/pngtree-man-working-on-computer-at-home-isometric-vector-png-image_321818.jpg&description=Man+working+on+computer+at+home+isometric+vector)[m
[41m+[m
