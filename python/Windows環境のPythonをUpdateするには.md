---
bibliography: 
repositoryUrl:
draft: false
---

# Windows環境のPythonをUpdateするには

Update前のバージョン。

```bash
python --version
# Python 3.11.5
```

インストーラーでUpdateする。

https://www.python.org/downloads/

```bash
python --version
# Python 3.12.2
```

新バージョンは、旧バージョンから独立した環境にインストールされる。

```bash
ls -1 /d/Users/xxx/AppData/Local/Programs/Python/
# Python311/
# Python312/
```

そのため、パッケージは何もインストールされていない。

```bash
pip freeze

```

したがって、パッケージをインストールする必要がある。

```bash
pip install -r requirements.txt
```

```bash
pip freeze
# boto3==1.26.54
# botocore==1.29.165
# ...
```
