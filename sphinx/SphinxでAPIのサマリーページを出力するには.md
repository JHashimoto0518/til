---
bibliography: 
  - https://www.sphinx-doc.org/ja/master/usage/extensions/autosummary.html
  - http://sphinx.shibu.jp/ext/autosummary.html
  - https://stackoverflow.com/questions/48074094/use-sphinx-autosummary-recursively-to-generate-api-documentation
  - https://bonbonbe.hatenablog.com/entry/2016/09/22/211445
repositoryUrl:
  - https://github.com/JHashimoto0518/sphinx-autodoc-exercise/
draft: true
---

# SphinxでAPIのサマリーページを出力するには

作業中。

https://www.perplexity.ai/search/sphinxnoconf-pynoyi-xia-noji-s-TiJosf1mR3.LFp8.Tl07CQ

conf.py を編集する。

```bash
# -extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon", "myst_parser"]
# +extensions = [
# +    "sphinx.ext.autodoc",
# +    "sphinx.ext.napoleon",
# +    "sphinx.ext.autosummary",
# +    "myst_parser",
# +]
# +
# +autosummary_generate = True
```

index.rst を編集する。

```rst

```bash
# +.. autosummary::
# +   :toctree: generated/
# +
# +   main
# +   main2
```

ドキュメントを生成する。

```bash
sphinx-apidoc -f -o ./docs/source ./
cd docs/ && make html
```
