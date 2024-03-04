---
bibliography: 
repositoryUrl:
draft: true
---

# RDSのエンドポイントを使い分ける

クラスターとインスタンスでは、異なるエンドポイントが割り当てられる。

| リソース     | ロール   | エンドポイントの例                                                                      |
| ------------ | -------- | --------------------------------------------------------------------------------------- |
| クラスター   | ライター | `<prefix>-cluster.cluster-<random-str>.ap-northeast-1.rds.amazonaws.com`    |
| クラスター   | リーダー | `<prefix>-cluster.cluster-ro-<random-str>.ap-northeast-1.rds.amazonaws.com` |
| インスタンス | ライター | `<prefix>.<random-str>.ap-northeast-1.rds.amazonaws.com`                    |
| インスタンス | リーダー | `<prefix>-reader.<random-str>.ap-northeast-1.rds.amazonaws.com` |
