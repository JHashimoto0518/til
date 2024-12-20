---
bibliography: 
  - http://ja.dochub.org/sphinx/index.html
  - https://www.sphinx-doc.org/ja/master/
  - https://qiita.com/futakuchi0117/items/4d3997c1ca1323259844
repositoryUrl:
  - https://github.com/JHashimoto0518/sphinx-autodoc-exercise
draft: false
published: false
---

# Sphinxでdocstringを抽出するには

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

読み込む Python ファイルのパスを追加する。

```python
import os
import sys

sys.path.insert(0, os.path.abspath("../../"))
```

extensions を編集する。

```python
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',
    'myst_parser'
]
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
# -o: 出力先, ./: main.py があるディレクトリ
sphinx-apidoc -f -o ./docs/source ./
```

modules.rst. main.rst が作成される。

```bash
git status -u
# ...
#        docs/source/modules.rst
```

```bash
cat docs/source/modules.rst 
# sphinx-autodoc-exercise
# =======================

# .. toctree::
#    :maxdepth: 4

#    main
```

```bash
cat docs/source/main.rst 
# main module
# ===========

# .. automodule:: main
#    :members:
#    :undoc-members:
#    :show-inheritance:
```

## index.rstの編集

`index.rst` にトップページに出力したいページ (今回は `modules.rst`) を追加する。

```bash

```rst
.. toctree::
   :maxdepth: 2
   :caption: Contents:

   modules
```

## HTMLファイルの生成

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

再度ビルドする。

```bash
make html
```

HTML ファイルが生成される。

![alt text](images/image1.png)

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
