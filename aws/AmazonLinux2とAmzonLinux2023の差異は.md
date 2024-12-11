---
bibliography: 
repositoryUrl:
draft: true
---

# AmazonLinux2とAmzonLinux2023の差異は

## まとめ記事

https://techblog.gmo-ap.jp/2024/12/11/amazon-linux-2023/

> 今回は弊社サービスのwordpressサーバーをamazon linux2 (AL2) からamazon linux 2023 (AL2023) に移行したので、AL2との違い等、移行内容についてまとめて記載します。

## その他

Amazon Linux 2023では、enロケールは存在せず、Cロケールしか存在していない。

https://tech.repro.io/entry/2024/12/11/155730

> 実はAWSのドキュメントをよく読むと、Ruby 3.2と3.3のruntimeで、AWSによって提供されるベースイメージがAmazon Linux 2からAmazon Linux 2023に変更されています。

> つまり、Ruby 3.3 runtime (Amazon Linux 2023)では、enロケールは存在せず、Cロケールしか存在していません。そのような環境において LANG=en_US.UTF-8 と指定してあっても、enロケールを使うことができずに外部エンコーディングが US-ASCII になってしまっていた……ということのようです。

