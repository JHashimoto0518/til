---
bibliography: 
repositoryUrl:
draft: true
---

# CloudFrontビヘイビアに信頼された署名者を設定するには

* ビューワーのアクセスを制限する - 信頼された署名者

ルートユーザーでマネージメントコンソールにサインインする必要があるため、テストできない。ユニットテストで代替した。

参考:
"署名付き URL と署名付き Cookie を作成できる署名者を指定する - Amazon CloudFront":https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/private-content-trusted-signers.html
  
> IAM ユーザーは CloudFront のキーペアを作成できません。キーペアを作成するには、ルートユーザーの認証情報を使用してサインインする必要があります。  
