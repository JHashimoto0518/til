# 複数のリソースを一括インポートする (literal)

S3バケットの例です。

最も簡単と思われる、バケット名をハードコードする方法です。

```ts:main.ts
import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "ap-northeast-1",
    });

    // バケットのリスト
    const bucketList = [
      "cdktf-test-web-20231024",
      "cdktf-test-log-20231024",
    ];

    // すべてのバケットに対してインポートを実行
    for (const bucketName of bucketList) {
      new S3Bucket(this, bucketName, {}).importFrom(bucketName);
    }
  }
}

const app = new App();
new MyStack(app, "config-driven-import");
app.synth();
```

`cdktf diff`を実行すると、期待通り 2 つのバケットをインポートする plan が出力されます。

<details><summary>output</summary>

```bash
$ cdktf diff
...
config-driven-import  Terraform will perform the following actions:
config-driven-import    # aws_s3_bucket.cdktf-test-log-20231024 (cdktf-test-log-20231024) will be imported
                          resource "aws_s3_bucket" "cdktf-test-log-20231024" {
                              arn                         = "arn:aws:s3:::cdktf-test-log-20231024"
                              bucket                      = "cdktf-test-log-20231024"
                              bucket_domain_name          = "cdktf-test-log-20231024.s3.amazonaws.com"
                              bucket_regional_domain_name = "cdktf-test-log-20231024.s3.ap-northeast-1.amazonaws.com"
                              hosted_zone_id              = "Z2M4EHUR26P7ZW"
                              id                          = "cdktf-test-log-20231024"
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
                                      bucket_key_enabled = false

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

                        # aws_s3_bucket.cdktf-test-web-20231024 (cdktf-test-web-20231024) will be imported
                          resource "aws_s3_bucket" "cdktf-test-web-20231024" {
                              arn                         = "arn:aws:s3:::cdktf-test-web-20231024"
                              bucket                      = "cdktf-test-web-20231024"
                              bucket_domain_name          = "cdktf-test-web-20231024.s3.amazonaws.com"
                              bucket_regional_domain_name = "cdktf-test-web-20231024.s3.ap-northeast-1.amazonaws.com"
                              hosted_zone_id              = "Z2M4EHUR26P7ZW"
                              id                          = "cdktf-test-web-20231024"
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
                                      bucket_key_enabled = false

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

                      Plan: 2 to import, 0 to add, 0 to change, 0 to destroy.
                      
                      ─────────────────────────────────────────────────────────────────────────────

                      Saved the plan to: plan

                      To perform exactly these actions, run the following command to apply:
                          terraform apply "plan
```

</details>

`cdktf deploy`で、インポートを実行します。

```bash
cdktf deploy
# ...                      
#                       Apply complete! Resources: 2 imported, 0 added, 0 changed, 0 destroyed.
# 
# No outputs found.
```

インポートが完了したら、`importFrom`の呼び出しは不要なので、削除します。

```typescript:main.ts
import { Construct } from "constructs";
import { App, TerraformStack } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "ap-northeast-1",
    });

    // バケットのリスト
    const bucketList = [
      "cdktf-test-web-20231024",
      "cdktf-test-log-20231024",
    ];

    // すべてのバケットに対してインポートを実行
    for (const bucketName of bucketList) {
-     new S3Bucket(this, bucketName, {}).importFrom(bucketName);        
+     new S3Bucket(this, bucketName, {});
    }
  }
}

const app = new App();
new MyStack(app, "config-driven-import");
app.synth();
```

コードを変更したので、念のため、再度`cdktf diff`を実行します。

```bash
cdktf diff
# ...
# config-driven-import  No changes. Your infrastructure matches the configuration.
# ...
```

期待通りに`No changes.`が出力され、コードとバケットの同期がとれていることがわかります。
