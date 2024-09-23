---
bibliography: 
repositoryUrl:
draft: false
---

# untracekedファイルを削除するには

dry run に相当するオプション。

```bash
git clean -n
```
  
削除を実行する。

```bash
git clean -f
```

ディレクトリも削除する場合は、`-d` オプションを追加する。

```bash
git clean -dn
```

```bash
git clean -df
```
