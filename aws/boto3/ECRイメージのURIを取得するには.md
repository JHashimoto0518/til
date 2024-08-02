---
bibliography: 
repositoryUrl:
draft: true
---

# ECRイメージのURIを取得するには

boto3 の describe_images のレスポンスには、イメージ URI が含まれない。

https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ecr/client/describe_images.html

公式ドキュメントに、イメージ URI のフォーマットが記載されていた。

https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/docker-pull-ecr-image.html

> イメージ名の形式は、タグを使用してプルする場合は registry/repository[:tag]、ダイジェストを使用してプルする場合は registry/repository[@digest] とします。

```bash
docker pull aws_account_id.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest
```
