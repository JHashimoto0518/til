# インストール済みパッケージをrequirements形式で出力するには

`requirements.txt` に出力する。

```bash
pip freeze > requirements.txt
```

```bash
cat requirements.txt 
# click==8.1.7
```

`requirements.txt` に出力したパッケージをインストールする。

```bash
pip install -r requirements.txt
```

開発用と本番用のパッケージを分ける。

```bash
cat requirements.txt 
# click==8.1.7
```

```bash
cat requirements-dev.txt
# -r requirements.txt
# pytest==7.4.3
```

## 参考

https://qiita.com/shun_sakamoto/items/7944d0ac4d30edf91fde
