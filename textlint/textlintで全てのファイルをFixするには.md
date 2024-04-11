# textlintで全てのファイルをFixするには

glob パターンを使用する。

再帰的にすべてのディレクトリを検索し、`.md`ファイルを対象にする例。

```bash
# ローカルインストールの場合は、 node_modules ディレクトリ内にインストールされるため、textlintコマンドは直接実行できない。
npx textlint --fix "**/*.md"
# 
# /home/.../cdktf deployの`Missing required argument: app`エラーを解決するには.md
#   11:7   ✔   原則として、全角文字と半角文字の間にスペースを入れます。  ja-spacing/ja-space-between-half-and-full-width
#   11:15  ✔   原則として、全角文字と半角文字の間にスペースを入れます。  ja-spacing/ja-space-between-half-and-full-width
# 
# ...
# 
# ✔ Fixed 19 problems
```
