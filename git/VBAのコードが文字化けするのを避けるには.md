# VBAのコードが文字化けするのを避けるには

`.gitattributes` を作成する。

`.bas` を管理するサンプル。

```ini
# Auto detect text files and perform LF normalization
* text=auto
*.bas text eol=crlf

# file encording
*.bas working-tree-encoding=sjis
*.bas diff=sjis
*.bas encoding=sjis
```

## 参考

- https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA-Git-%E3%81%AE%E5%B1%9E%E6%80%A7
- https://blog.ue-y.me/vba2021/
- https://qiita.com/nacam403/items/23511637335fc221bba2
