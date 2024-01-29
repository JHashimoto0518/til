---
bibliography: 
    - https://dev.classmethod.jp/articles/re-introduction-2020-direct-connect/
repositoryUrl:
draft: false
---

# Direct-Connectリソースの関連は

Private VIF と Direct Connect Gateway を利用するパターン。

![Alt text](./images/diect-connect-diagram.drawio.png)

AWS クラウドへの物理的な接続を提供する拠点のことを「Direct Connect ロケーション」と呼ぶ。

オンプレミスから Direct Connect ロケーションまでを専用線で接続する。この物理接続のことを「接続」と呼ぶ。

物理接続の中に、複数の論理インターフェースを保持できる。これを VIF と呼ぶ。
