---
bibliography: 
  - http://ja.dochub.org/sphinx/index.html
  - https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844
repositoryUrl:
  - https://github.com/JHashimoto0518/sphinx-autodoc-exercise
draft: true
---

# Sphinxをクイックスタートするには

## 環境構築

仮想環境の利用を推奨。

```bash
python3 -m venv venv
. venv/bin/activate
```

Sphinx をインストールする。

```bash
pip install sphinx
```

`requirements.txt` を出力しておくと、環境の再構築が容易になる。
  
```bash
pip freeze > requirements.txt
```

以降の検証は Sphinx 8.0.2 で行う。

```bash
cat requirements.txt | grep Sphinx
# Sphinx==8.0.2
```

## プロジェクトの作成

Sphinx プロジェクトのルートディレクトリを作成する。

```bash
mkdir docs
```

Sphinx プロジェクトのテンプレートを作成する。

```bash
sphinx-quickstart docs
```

prompt に従って入力する。

```bash
> Separate source and build directories (y/n) [n]: y
> Project name: MyProject
> Author name(s): Junichi Hashimoto
> Project release []: 1.0.0
> Project language [en]: ja
```

docs ディレクトリにテンプレートが作成される。

```bash
tree docs/
# docs/
# ├── build
# ├── make.bat
# ├── Makefile
# └── source
#     ├── conf.py
#     ├── index.rst
#     ├── _static
#     └── _templates
```

## conf.pyの編集

extensions を編集する。

```python
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',
    'myst_parser'
]
```

## index.rstの編集

`index.rst` にトップページで追加したいモジュール (今回は `main` モジュール) を追加する。

```rst
.. toctree::
   :maxdepth: 2
   :caption: Contents:

   main
```

## ドキュメントを抽出するPythonモジュールの作成

docs ディレクトリと同じ階層に `main.py` を作成する。

```python
class TestClass:
    """Summary line.
    """

    def testfunc(self, x, y):
        """sum

        Args:
            x (int): 1st argument
            y (int): 2nd argument

        Returns:
            int: sum result

        Examples:
            >>> print(testfunc(2,5))
            7
        """
        return x + y
```

## ドキュメントを生成する

```bash
# -o: 出力先
sphinx-apidoc -f -o ./docs/source ../
```

modules.rst が作成される。

```bash
git status -u
# ...
#        docs/source/modules.rst

```bash
cat docs/source/modules.rst 
# jhashimoto0518
# ==============

# .. toctree::
#    :maxdepth: 4
```

rst ファイルをビルドする。

```bash
cd docs
make html
# Running Sphinx v8.0.2
# loading translations [ja]... done

# Extension error:
# Could not import extension myst_parser (exception: No module named 'myst_parser')
# make: *** [Makefile:20: html] Error 2
```

`myst_parser` がインストールされていないためエラーが発生する。

```bash
pip install myst-parser
```

```bash
make html
# /home/jhashimoto/rep/jhashimoto0518/sphinx-autodoc-exercise/docs/source/index.rst:14: WARNING: toctree contains reference to nonexisting document 'main' [toc.not_readable]
# ...
# checking consistency... /home/jhashimoto/rep/jhashimoto0518/sphinx-autodoc-exercise/docs/source/modules.rst: WARNING: document isn't included in any toctree
# ...
```

requiremets.txt を更新する。

```bash
pip freeze > ../requirements.txt
git diff
# diff --git a/requirements.txt b/requirements.txt
# index 6f90474..974e7cf 100644
# --- a/requirements.txt
# +++ b/requirements.txt
# @@ -6,9 +6,14 @@ docutils==0.21.2
#  idna==3.8
#  imagesize==1.4.1
#  Jinja2==3.1.4
# +markdown-it-py==3.0.0
#  MarkupSafe==2.1.5
# +mdit-py-plugins==0.4.1
# +mdurl==0.1.2
# +myst-parser==4.0.0
#  packaging==24.1
#  Pygments==2.18.0
# +PyYAML==6.0.2
#  requests==2.32.3
#  snowballstemmer==2.2.0
#  Sphinx==8.0.2
```

HTML に main モジュールの情報が出力されない。

- [ ] index.rst の仕様を確認する。