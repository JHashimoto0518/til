---
bibliography: 
    - https://...
repositoryUrl:
    - https://github.com/...
draft: true
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

```tf
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
aws_s3_bucket.this["tf-bulk-import-test-2"]: Preparing import... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Preparing import... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]

Terraform will perform the following actions:

  # aws_s3_bucket.this["tf-bulk-import-test-1"] will be imported
    resource "aws_s3_bucket" "this" {
        arn                         = "arn:aws:s3:::tf-bulk-import-test-1"
        bucket                      = "tf-bulk-import-test-1"
        bucket_domain_name          = "tf-bulk-import-test-1.s3.amazonaws.com"
        bucket_regional_domain_name = "tf-bulk-import-test-1.s3.ap-northeast-1.amazonaws.com"
        hosted_zone_id              = "Z2M4EHUR26P7ZW"
        id                          = "tf-bulk-import-test-1"
        object_lock_enabled         = false
        region                      = "ap-northeast-1"
        request_payer               = "BucketOwner"
        tags                        = {}
        tags_all                    = {}

        grant {
            id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598"
            permissions = [
                "FULL_CONTROL",
            ]
            type        = "CanonicalUser"
        }

        server_side_encryption_configuration {
            rule {
                bucket_key_enabled = true

                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }

        versioning {
            enabled    = false
            mfa_delete = false
        }
    }

  # aws_s3_bucket.this["tf-bulk-import-test-2"] will be imported
    resource "aws_s3_bucket" "this" {
        arn                         = "arn:aws:s3:::tf-bulk-import-test-2"
        bucket                      = "tf-bulk-import-test-2"
        bucket_domain_name          = "tf-bulk-import-test-2.s3.amazonaws.com"
        bucket_regional_domain_name = "tf-bulk-import-test-2.s3.ap-northeast-1.amazonaws.com"
        hosted_zone_id              = "Z2M4EHUR26P7ZW"
        id                          = "tf-bulk-import-test-2"
        object_lock_enabled         = false
        region                      = "ap-northeast-1"
        request_payer               = "BucketOwner"
        tags                        = {}
        tags_all                    = {}

        grant {
            id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598"
            permissions = [
                "FULL_CONTROL",
            ]
            type        = "CanonicalUser"
        }

        server_side_encryption_configuration {
            rule {
                bucket_key_enabled = true

                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }

        versioning {
            enabled    = true
            mfa_delete = false
        }
    }

Plan: 2 to import, 0 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

apply で、インポートを実行する。

```bash
terraform apply -var="buckets=${buckets}"
aws_s3_bucket.this["tf-bulk-import-test-1"]: Preparing import... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Preparing import... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]

Terraform will perform the following actions:

  # aws_s3_bucket.this["tf-bulk-import-test-1"] will be imported
    resource "aws_s3_bucket" "this" {
        arn                         = "arn:aws:s3:::tf-bulk-import-test-1"
        bucket                      = "tf-bulk-import-test-1"
        bucket_domain_name          = "tf-bulk-import-test-1.s3.amazonaws.com"
        bucket_regional_domain_name = "tf-bulk-import-test-1.s3.ap-northeast-1.amazonaws.com"
        hosted_zone_id              = "Z2M4EHUR26P7ZW"
        id                          = "tf-bulk-import-test-1"
        object_lock_enabled         = false
        region                      = "ap-northeast-1"
        request_payer               = "BucketOwner"
        tags                        = {}
        tags_all                    = {}

        grant {
            id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598"
            permissions = [
                "FULL_CONTROL",
            ]
            type        = "CanonicalUser"
        }

        server_side_encryption_configuration {
            rule {
                bucket_key_enabled = true

                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }

        versioning {
            enabled    = false
            mfa_delete = false
        }
    }

  # aws_s3_bucket.this["tf-bulk-import-test-2"] will be imported
    resource "aws_s3_bucket" "this" {
        arn                         = "arn:aws:s3:::tf-bulk-import-test-2"
        bucket                      = "tf-bulk-import-test-2"
        bucket_domain_name          = "tf-bulk-import-test-2.s3.amazonaws.com"
        bucket_regional_domain_name = "tf-bulk-import-test-2.s3.ap-northeast-1.amazonaws.com"
        hosted_zone_id              = "Z2M4EHUR26P7ZW"
        id                          = "tf-bulk-import-test-2"
        object_lock_enabled         = false
        region                      = "ap-northeast-1"
        request_payer               = "BucketOwner"
        tags                        = {}
        tags_all                    = {}

        grant {
            id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598"
            permissions = [
                "FULL_CONTROL",
            ]
            type        = "CanonicalUser"
        }

        server_side_encryption_configuration {
            rule {
                bucket_key_enabled = true

                apply_server_side_encryption_by_default {
                    sse_algorithm = "AES256"
                }
            }
        }

        versioning {
            enabled    = true
            mfa_delete = false
        }
    }

Plan: 2 to import, 0 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.this["tf-bulk-import-test-1"]: Importing... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Import complete [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Importing... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Import complete [id=tf-bulk-import-test-2]

Apply complete! Resources: 2 imported, 0 added, 0 changed, 0 destroyed.
```

念のため、再度 plan を出力し、構成ファイルとの差分がないことを確認します。

```bash
terraform plan -var="buckets=${buckets}"
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```

state を確認すると、バージョニングの構成差異も正しく取り込まれていることがわかります。

```json
{
  "version": 4,
  "terraform_version": "1.7.0",
  "serial": 1,
  "lineage": "38ff5439-6295-26ef-8545-7136207041ef",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "aws_s3_bucket",
      "name": "this",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "index_key": "tf-bulk-import-test-1",
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": null,
            "arn": "arn:aws:s3:::tf-bulk-import-test-1",
            "bucket": "tf-bulk-import-test-1",
            "bucket_domain_name": "tf-bulk-import-test-1.s3.amazonaws.com",
            "bucket_prefix": "",
            "bucket_regional_domain_name": "tf-bulk-import-test-1.s3.ap-northeast-1.amazonaws.com",
            "cors_rule": [],
            "force_destroy": null,
            "grant": [
              {
                "id": "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598",
                "permissions": [
                  "FULL_CONTROL"
                ],
                "type": "CanonicalUser",
                "uri": ""
              }
            ],
            "hosted_zone_id": "Z2M4EHUR26P7ZW",
            "id": "tf-bulk-import-test-1",
            "lifecycle_rule": [],
            "logging": [],
            "object_lock_configuration": [],
            "object_lock_enabled": false,
            "policy": "",
            "region": "ap-northeast-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [
              {
                "rule": [
                  {
                    "apply_server_side_encryption_by_default": [
                      {
                        "kms_master_key_id": "",
                        "sse_algorithm": "AES256"
                      }
                    ],
                    "bucket_key_enabled": true
                  }
                ]
              }
            ],
            "tags": {},
            "tags_all": {},
            "timeouts": null,
            "versioning": [
              {
                "enabled": false,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjM2MDAwMDAwMDAwMDAsInJlYWQiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMCJ9"
        },
        {
          "index_key": "tf-bulk-import-test-2",
          "schema_version": 0,
          "attributes": {
            "acceleration_status": "",
            "acl": null,
            "arn": "arn:aws:s3:::tf-bulk-import-test-2",
            "bucket": "tf-bulk-import-test-2",
            "bucket_domain_name": "tf-bulk-import-test-2.s3.amazonaws.com",
            "bucket_prefix": "",
            "bucket_regional_domain_name": "tf-bulk-import-test-2.s3.ap-northeast-1.amazonaws.com",
            "cors_rule": [],
            "force_destroy": null,
            "grant": [
              {
                "id": "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598",
                "permissions": [
                  "FULL_CONTROL"
                ],
                "type": "CanonicalUser",
                "uri": ""
              }
            ],
            "hosted_zone_id": "Z2M4EHUR26P7ZW",
            "id": "tf-bulk-import-test-2",
            "lifecycle_rule": [],
            "logging": [],
            "object_lock_configuration": [],
            "object_lock_enabled": false,
            "policy": "",
            "region": "ap-northeast-1",
            "replication_configuration": [],
            "request_payer": "BucketOwner",
            "server_side_encryption_configuration": [
              {
                "rule": [
                  {
                    "apply_server_side_encryption_by_default": [
                      {
                        "kms_master_key_id": "",
                        "sse_algorithm": "AES256"
                      }
                    ],
                    "bucket_key_enabled": true
                  }
                ]
              }
            ],
            "tags": {},
            "tags_all": {},
            "timeouts": null,
            "versioning": [
              {
                "enabled": true,
                "mfa_delete": false
              }
            ],
            "website": [],
            "website_domain": null,
            "website_endpoint": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjoxMjAwMDAwMDAwMDAwLCJkZWxldGUiOjM2MDAwMDAwMDAwMDAsInJlYWQiOjEyMDAwMDAwMDAwMDAsInVwZGF0ZSI6MTIwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMCJ9"
        }
      ]
    }
  ],
  "check_results": null
}

```

## インポートブロックの削除

不要になったインポートブロックを削除します。

```diff_tf
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

- import {
-   for_each = { for b in var.buckets : b => b }
-   to       = aws_s3_bucket.this[each.key]
-   id       = each.value
- }

resource "aws_s3_bucket" "this" {
  for_each = { for b in var.buckets : b => b }
  bucket   = each.value
}
```

```bash
terraform plan -var="buckets=${buckets}"
# aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]
# aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]
# 
# No changes. Your infrastructure matches the configuration.
# 
# Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```

問題なさそうなので、apply します。

```bash
terraform apply -var="buckets=${buckets}"
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
```

再度 plan。

```bash
terraform plan -var="buckets=${buckets}"
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```

## 構成の変更

インポートにより、既存バケットを Terraform 管理に移行できたので、構成変更を試してみる。

tf-bulk-import-test-2 のみ、オブジェクトロックを有効にする。

まず、for-each を利用している resource ブロックをばらす。

```tf
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

resource "aws_s3_bucket" "test-1" {
  bucket = "tf-bulk-import-test-1"
}

resource "aws_s3_bucket" "test-2" {
  bucket = "tf-bulk-import-test-2"
}
```

variable も不要なので、削除する。

`terraform plan` を実行すると、期待に反して、destoroy and create の plan が出力される。

```bash
aws_s3_bucket.this["tf-bulk-import-test-2"]: Refreshing state... [id=tf-bulk-import-test-2]
aws_s3_bucket.this["tf-bulk-import-test-1"]: Refreshing state... [id=tf-bulk-import-test-1]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # aws_s3_bucket.test-1 will be created
  + resource "aws_s3_bucket" "test-1" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "tf-bulk-import-test-1"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # aws_s3_bucket.test-2 will be created
  + resource "aws_s3_bucket" "test-2" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "tf-bulk-import-test-2"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # aws_s3_bucket.this["tf-bulk-import-test-1"] will be destroyed
  # (because aws_s3_bucket.this is not in configuration)
  - resource "aws_s3_bucket" "this" {
      - arn                         = "arn:aws:s3:::tf-bulk-import-test-1" -> null
      - bucket                      = "tf-bulk-import-test-1" -> null
      - bucket_domain_name          = "tf-bulk-import-test-1.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-bulk-import-test-1.s3.ap-northeast-1.amazonaws.com" -> null
      - hosted_zone_id              = "Z2M4EHUR26P7ZW" -> null
      - id                          = "tf-bulk-import-test-1" -> null
      - object_lock_enabled         = false -> null
      - region                      = "ap-northeast-1" -> null
      - request_payer               = "BucketOwner" -> null
      - tags                        = {} -> null
      - tags_all                    = {} -> null

      - grant {
          - id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = true -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm = "AES256" -> null
                }
            }
        }

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

  # aws_s3_bucket.this["tf-bulk-import-test-2"] will be destroyed
  # (because aws_s3_bucket.this is not in configuration)
  - resource "aws_s3_bucket" "this" {
      - arn                         = "arn:aws:s3:::tf-bulk-import-test-2" -> null
      - bucket                      = "tf-bulk-import-test-2" -> null
      - bucket_domain_name          = "tf-bulk-import-test-2.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "tf-bulk-import-test-2.s3.ap-northeast-1.amazonaws.com" -> null
      - hosted_zone_id              = "Z2M4EHUR26P7ZW" -> null
      - id                          = "tf-bulk-import-test-2" -> null
      - object_lock_enabled         = false -> null
      - region                      = "ap-northeast-1" -> null
      - request_payer               = "BucketOwner" -> null
      - tags                        = {} -> null
      - tags_all                    = {} -> null

      - grant {
          - id          = "d03aad499a43b0490edc04b16d5e8673281a97f4127f8b0a8f2a3d6ff57c0598" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = true -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm = "AES256" -> null
                }
            }
        }

      - versioning {
          - enabled    = true -> null
          - mfa_delete = false -> null
        }
    }

Plan: 2 to add, 0 to change, 2 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

これは、state の名前が異なるため、構成ファイルで宣言したバケットが、管理下のバケットとは別のリソースと判断されることによる。

state を確認してみる。

```bash
terraform state list --state ./terraform.tfstate
# aws_s3_bucket.this["tf-bulk-import-test-1"]
# aws_s3_bucket.this["tf-bulk-import-test-2"]
```

期待する state。

- aws_s3_bucket.test-1
- aws_s3_bucket.test-2

安全にリファクタリングするには、`moved` ブロックが使える。

https://www.hashicorp.com/blog/terraform-1-1-improves-refactoring-and-the-cloud-cli-experience#easier-and-safer-refactoring-with-moved-statements

moved ブロックで、期待する state 名に変更する。

```tf
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

resource "aws_s3_bucket" "test-1" {
  bucket = "tf-bulk-import-test-1"
}

resource "aws_s3_bucket" "test-2" {
  bucket = "tf-bulk-import-test-2"
}

moved {
  from = aws_s3_bucket.this["tf-bulk-import-test-1"]
  to   = aws_s3_bucket.test-1
}

moved {
  from = aws_s3_bucket.this["tf-bulk-import-test-2"]
  to   = aws_s3_bucket.test-2
}
```

moved の plan が出力される。

```bash
terraform plan
aws_s3_bucket.test-1: Refreshing state... [id=tf-bulk-import-test-1]
aws_s3_bucket.test-2: Refreshing state... [id=tf-bulk-import-test-2]

Terraform will perform the following actions:

  # aws_s3_bucket.this["tf-bulk-import-test-1"] has moved to aws_s3_bucket.test-1
    resource "aws_s3_bucket" "test-1" {
        id                          = "tf-bulk-import-test-1"
        tags                        = {}
        # (9 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }

  # aws_s3_bucket.this["tf-bulk-import-test-2"] has moved to aws_s3_bucket.test-2
    resource "aws_s3_bucket" "test-2" {
        id                          = "tf-bulk-import-test-2"
        tags                        = {}
        # (9 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }

Plan: 0 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

