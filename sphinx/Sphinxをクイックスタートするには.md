# Sphinxをクイックスタートするには

`requirements.txt`に`sphinx`を追加する。

```bash
cat requirements.txt 
sphinx
# ...
```

インストールする。

```bash
pip install -r requirements.txt
```

プロジェクトテンプレートをビルドする。

```bash
$ sphinx-quickstart \
  doc # ディレクトリ名
# ...
# "source" and "build" directories within the root path.
> Separate source and build directories (y/n) [n]: y

# The project name will occur in several places in the built documentation.
> Project name: sample-project
> Author name(s): your-name
> Project release []: 0.1
# ...
```
