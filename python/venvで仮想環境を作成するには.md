# venvで仮想環境を作成するには

Ubuntu では、先にパッケージのインストールが必要。

```bash
sudo apt install python3.10-venv
```

パッケージがインストールされていないと、以下のエラーで仮想環境作成に失敗する。

```bash
python3 -m venv venv
# The virtual environment was not created successfully because ensurepip is not
# available.  On Debian/Ubuntu systems, you need to install the python3-venv
# package using the following command.
# 
#     apt install python3.10-venv
# 
# You may need to use sudo with that command.  After installing the python3-venv
# package, recreate your virtual environment.
# 
# Failing command: /home/xxx/venv/bin/python3
```

カレントディレクトリ直下に、仮想環境の管理ディレクトリ`venv`を作成する。

```bash
python3 -m venv venv
```

仮想環境をアクティベートする。この状態で `pip install` すると、仮想環境にインストールされる。

```bash
. venv/bin/activate
# (venv) xxx@DESKTOP-EONL0GM:~/xxx/$ 
```

仮想環境から抜ける。

```bash
deactivate
# xxx@DESKTOP-EONL0GM:~/xxx/$ 
```

仮想環境を削除する。

```bash
rm -rf venv
```

ディレクトリを Git で管理する場合は、`venv/` を `.gitignore` に追加する。

https://github.com/github/gitignore/blob/main/Python.gitignore

## 参考

https://docs.python.org/ja/3/library/venv.html

https://qiita.com/shun_sakamoto/items/7944d0ac4d30edf91fde

https://qiita.com/hrmc/items/264857074b0c26dfeeaf
