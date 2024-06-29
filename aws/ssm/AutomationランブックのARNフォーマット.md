---
bibliography: 
repositoryUrl:
draft: false
---

# AutomationランブックのARNフォーマット

ランブック (automation-definition リソース) の ARN には、次の 2 つのフォーマットがある。

1. 自己所有またはパブリック共有[^1]されたランブック (アカウント ID を含む)
   - `arn:aws:ssm:ap-northeast-1:123456789012:automation-definition/my-runbook`
2. Amazon が所有するランブック (アカウント ID を含まない)
   - `arn:aws:ssm:ap-northeast-1::automation-definition/AWS-StartStopAuroraCluster`

https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/security_iam_service-with-iam.html

> Amazon が所有するドキュメントやオートメーション定義リソース、および Amazon とサードパーティの両方のソースから提供されるパブリックパラメータには、ARN 形式のアカウント ID は含まれていません。

[^1]:サードパーティー製のランブックは、パブリック共有として提供される。