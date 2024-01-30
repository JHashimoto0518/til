---
bibliography: 
    - https://qiita.com/nagito25/items/2463a677e46210c6a90f
repositoryUrl:
draft: false
---

# 過去のコミットのcommitterとauthorを変更するには

email と name を設定しておく。

```bash
git config user.email "46337314+JHashimoto0518@users.noreply.github.com"
git config user.email
git config user.name "Junichi Hashimoto"
git config user.name
```

全てのコミットの committer と author にも反映させる。

```bash
cd <the top level of the working tree>
```

```bash
git filter-branch -f --env-filter 'GIT_AUTHOR_NAME="`git config user.name`";GIT_AUTHOR_EMAIL="`git config user.email`";GIT_COMMITTER_NAME="`git config user.name`";GIT_COMMITTER_EMAIL="`git config user.email`";' HEAD
# WARNING: git-filter-branch has a glut of gotchas generating mangled history
#          rewrites.  Hit Ctrl-C before proceeding to abort, then use an
#          alternative filtering tool such as 'git filter-repo'
#          (https://github.com/newren/git-filter-repo/) instead.  See the
#          filter-branch manual page for more details; to squelch this warning,
#          set FILTER_BRANCH_SQUELCH_WARNING=1.
# Proceeding with filter-branch...
# 
# Rewrite 3123936ea8ceef37c6a48f460de24c1af98a7371 (4/4) (0 seconds passed, remaining 0 predicted)    
# Ref 'refs/heads/main' was rewritten
```

なお、`filter-branch` は推奨されてなく、代替として `filter-repo` が紹介されている。

https://git-scm.com/docs/git-filter-branch

> These safety and performance issues cannot be backward compatibly fixed and as such, its use is not recommended. Please use an alternative history filtering tool such as git filter-repo.
