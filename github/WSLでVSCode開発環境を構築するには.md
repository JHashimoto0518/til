---
bibliography: 
repositoryUrl:
draft: false
---

# WSLでVS Code開発環境を構築するには

https://learn.microsoft.com/ja-jp/windows/wsl/install

WSLをインストールする。WSLとデフォルトのディストリビューションであるUbuntuがインストールされる。

```bash
$ wsl --install
# ダウンロード中: Ubuntu
# インストール中: Ubuntu
# ディストリビューションが正常にインストールされました。'wsl.exe -d Ubuntu' を使用して起動できます
# PS C:\Users\junic> wsl.exe --list --verbose
#   NAME      STATE           VERSION
# * Ubuntu    Stopped         2
```

WindowsターミナルからUbuntuに接続し、ユーザーを作成する。

```bash
# Provisioning the new WSL instance Ubuntu
# This might take a while...
# Create a default Unix user account: my-user
```

VS Codeで`WSL`拡張機能をインストールする。

`Ctrl + Shift + P`を入力し、`WSL: Connect to WSL`を実行する。
