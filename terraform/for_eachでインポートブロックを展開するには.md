---
bibliography: 
repositoryUrl:
    - https://github.com/JHashimoto0518/terraform-exercise/tree/main/bulk-import-with-block
draft: false
---

# for-eachでインポートブロックを展開するには

1.7 で、インポートブロックが for-each をサポートした。

https://www.hashicorp.com/blog/terraform-1-7-adds-test-mocking-and-config-driven-remove

> Terraform 1.7 also includes an enhancement for config-driven import: the ability to expand import blocks using for_each loops.

## バケットの準備

Terraform 管理下にないバケットを 2 つ用意した。

- tf-bulk-import-test-1
- tf-bulk-import-test-2

構成の異なるバケットで検証するため、tf-bulk-import-test-2 のみ、バージョニングを有効化しておく。

AWS の Credential を設定する。今回は環境変数を利用する。

```bash
export AWS_PROFILE="<replace your profile>"
```

```bash
bucket_name=tf-bulk-import-test-1
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Suspended && aws s3api get-bucket-versioning --bucket ${bucket_name}
# {
#     "Status": "Suspended"
# }
```

```bash
bucket_name=tf-bulk-import-test-2
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled && aws s3api get-bucket-versioning --bucket ${bucket_name}
# {
#     "Status": "Enabled"
# }
```

## インポートする

AWS CLI でバケット名のリストを変数に格納する。

```bash
buckets=$(aws s3api list-buckets --query "Buckets[?starts_with(Name, 'tf-bulk-import-test')].Name" --output json | jq -c .)
echo ${buckets} 
# ["tf-bulk-import-test-1","tf-bulk-import-test-2"]
```

main.tf を記述する。今回は、検証目的なので簡易的にローカルで state を管理する。

```hcl
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "buckets" {
  type        = list(string)
  description = "buckets to import"
}

import {
  for_each = { for b in var.buckets : b => b }
  to       = aws_s3_bucket.this[each.key]
  id       = each.value
}

resource "aws_s3_bucket" "this" {
  for_each = { for b in var.buckets : b => b }
bucket   = each.value
}
```

初期化する。

```bash
terraform init
```

plan を確認する。

```bash
terraform plan -var="buckets=${buckets}"
#
# Plan: 2 to import, 0 to add, 0 to change, 0 to destroy.
```

apply で、インポートを実行する。

```bash
terraform apply -var="buckets=${buckets}"
# 
# Apply complete! Resources: 2 imported, 0 added, 0 changed, 0 destroyed.
```
