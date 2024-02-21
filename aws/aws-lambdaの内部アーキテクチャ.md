---
bibliography: 
repositoryUrl:
draft: false
---

# aws-lambdaの内部アーキテクチャ

QCon San Francisco 2023 の初日に、AWS のシニアプリンシパルエンジニアである Mike Danilov 氏が、AWS Lambda とその概要について発表した。この講演は「Architectures You've Always Wondered About」トラックの一部。

https://www.infoq.com/jp/news/2024/02/aws-lambda-under-the-hood/

Lambda は Rust を採用している。

> Danilov氏は、Assignment Serviceの導入とRustプログラミング言語の採用が、AWS Lambdaの呼び出しルーティングシステムに安定性とパフォーマンスをもたらしたが、