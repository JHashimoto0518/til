---
bibliography: 
repositoryUrl:
draft: false
---

# git-worktreeで複数ブランチを同時にチェックアウトするには

元の作業ディレクトリと同じ階層にチェックアウトします。

```bash
git worktree add ../fix/this-error fix/this-error
# Preparing worktree (checking out 'fix/this-error')
# HEAD is now at 8f0f67e xxxxx
```

```bash
git branch
#   develop
# * feat/this-feature
# + fix/this-error
#   main
```

作業が終わったら削除します。

```bash
git worktree remove fix/this-error
tree -L 1 ../../../../fix
# ../../../../fix
#
# 0 directories, 0 files
```

```bash
git branch
#   develop
# * feat/this-feature
#   fix/this-error
#   main
```
