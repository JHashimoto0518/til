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
