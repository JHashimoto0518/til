# WSLで開発したコードをWindows環境でコミットするには

`core.autocrlf` を `true` に設定しておく。これで、Windows 環境の場合は、コミットする際に CRLF は LF に、チェックアウトする際に LF は CRLF に変換される。

```bash
git config core.autocrlf
# true
```

コードを WSL から Windows ファイルシステムにコピーする。

差分が改行コードのみの場合でも、`modified` として検出される。

```bash
git status
# ...
#         modified:   ...
```

差分が改行コードのみの場合は、ステージングで差分が解消される。

```bash
git add .
```

```bash
git status
# On branch feature/ec2
# nothing to commit, working tree clean
```

コードに変更がある場合は、当然 `modified` として検出される。

```bash
git status
# ...
#         modified:   ...
```

ステージングすると、`warning` が出力されるが、かまわずコミットすればよい。

```bash
git add .
# warning: in the working copy of '...', LF will be replaced by CRLF the next time Git touches it
```

## 参考

https://qiita.com/uggds/items/00a1974ec4f115616580