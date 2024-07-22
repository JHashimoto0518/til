# リモートリポジトリに存在しないブランチをpushするには

```bash
fatal: The current branch master has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin master

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.
```

`master` ブランチの例。

ローカルブランチに対してアップストリームを設定する。

```bash
git push --set-upstream origin master
```

または

```bash
git push -u origin master
```

アップストリームブランチを確認する。

```bash
git branch -vv
#   main   54xxxxx [origin/main] add README
# * master 54xxxxx [origin/master] add README
```

perplexity の解説。

> このコマンドは以下の動作を行います:
> 
> - origin はリモートリポジトリの名前(通常はデフォルトでこの名前が使用されます)
> - master はプッシュするローカルブランチの名前
> - -u オプション(または --set-upstream)は、ローカルの develop ブランチをリモートの develop ブランチに関連付けます
> 
> このコマンドを実行すると、リモートリポジトリに新しく develop ブランチが作成され、ローカルの変更内容がそこにプッシュされます。
