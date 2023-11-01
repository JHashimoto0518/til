# 作業ブランチの変更をまとめてmainブランチに取り込むには

作業ブランチを`research/bulk-import`とする。

mainに移動する。

```bash
git switch main
```

`--squash`を指定して、mergeする。

```bash
git merge --squash research/bulk-import 
# Updating 1eab1dc..dcf0a8a
# Fast-forward
# Squash commit -- not updating HEAD
#  bulk-import-sample/main.ts | 21 +++++++++++----------
#  1 file changed, 11 insertions(+), 10 deletions(-)
```

作業ブランチのすべての変更が、ステージングされる。

```bash
git status
# On branch main
# Your branch is up to date with 'origin/main'.
# 
# Changes to be committed:
#   (use "git restore --staged <file>..." to unstage)
#         modified:   main.ts
```

コミットする。

```bash
git commit -m "imported with for-each"
# [main c846151] imported with for-each
#  1 file changed, 11 insertions(+), 10 deletions(-)
```
