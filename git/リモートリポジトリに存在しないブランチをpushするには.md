# リモートリポジトリに存在しないブランチをpushするには

```bash
fatal: The current branch master has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin master

To have this happen automatically for branches without a tracking
upstream, see 'push.autoSetupRemote' in 'git help config'.
```

ローカルブランチに対してアップストリームを設定する。

```bash
git push --set-upstream origin master
```

アップストリームブランチを確認する。

```bash
git branch -vv
#   main   54xxxxx [origin/main] add README
# * master 54xxxxx [origin/master] add README
```
