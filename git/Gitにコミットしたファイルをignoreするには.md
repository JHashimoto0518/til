# Gitにコミットしたファイルをignoreするには

`.gitignore`自身を ignore する例。

```bash
cat .gitignore 
# .gitignore
# ...
```

コミット済みのファイルを`.gitignore`に追加しても、変更として検知される。

```bash
git status
# On branch feature/ec2
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git restore <file>..." to discard changes in working directory)
#         modified:   .gitignore
# ...
```

`git rm --cached `で、管理対象から外す。

```bash
rm --cached .gitignore 
# rm '.../.gitignore'
```

削除が検出される。

```bash
git status
# On branch feature/ec2
# Changes to be committed:
#   (use "git restore --staged <file>..." to unstage)
#         deleted:    .gitignore
```

コミットする。

```bash
git commit -m "remove: .gitignore を削除"
# [feature/ec2 a2ecc90]remove: .gitignore を削除
#  1 file changed, 5 deletions(-)
#  delete mode 100644 xxx/.gitignore
```

ignore できた。

```bash
git status
# On branch feature/ec2
# nothing to commit, working tree clean
```
