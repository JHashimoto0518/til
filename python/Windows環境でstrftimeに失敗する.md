---
bibliography: 
repositoryUrl:
draft: false
---

# Windows環境でstrftimeに失敗する

strftime関数が使用する書式コードはOS依存で、WindowsとLinuxでサポートする書式コードが異なるため、strftimeは利用しない。

次のコードはLinuxではテストパスするが、Windowsではテストに失敗する。

```python
str = time.strftime("%-H時間%-M分%-S秒", seconds)
```

https://docs.python.org/ja/3/library/datetime.html#strftime-and-strptime-format-codes

> Python はプラットフォームの C ライブラリの strftime() 関数を呼び出していて、プラットフォームごとにその実装が異なるのはよくあることなので、サポートされる書式コード全体はプラットフォームごとに様々です。

f文字列を使用することで、strftime関数を使用せずに書式を指定することができる。

```python
dt = time.gmtime(seconds)
str = f"{dt.tm_hour}時間{dt.tm_min}分{dt.tm_sec}秒"
```
