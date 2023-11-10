# 複数リソースを一括インポートする (construct)

バケットの例。

```typescript:main.ts
import { Construct } from "constructs";
import {
  App,
  TerraformStack,
} from "cdktf";

import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "ap-northeast-1",
    });

    new S3Buckets(
      this,
      "bucket",
      ["cdktf-test-web-20231024", "cdktf-test-log-20231024"]
    );
  }
}

// S3バケット
class S3Buckets extends Construct {
  constructor(scope: Construct, id: string, bucketNames: string[]) {
    super(scope, id);

    // すべてのバケット
    bucketNames.forEach((name) => {
      new S3Bucket(this, name, {}).importFrom(name);
    });
  }
}

const app = new App();
new MyStack(app, "config-driven-import");
app.synth();
```

複数バケットをインポートする plan が出力される。

```bash
cdktf diff
...
config-driven-import  Terraform will perform the following actions:
config-driven-import    # aws_s3_bucket.bucket_cdktf-test-log-20231024_D553C520 (bucket/cdktf-test-log-20231024) will be imported
                          resource "aws_s3_bucket" "bucket_cdktf-test-log-20231024_D553C520" {
...
                          }
                        # aws_s3_bucket.bucket_cdktf-test-web-20231024_957F5966 (bucket/cdktf-test-web-20231024) will be imported
                          resource "aws_s3_bucket" "bucket_cdktf-test-web-20231024_957F5966" {
...
                          }

                      Plan: 2 to import, 0 to add, 0 to change, 0 to destroy.
...                      
```

インポートを実行する。

```bash
cdktf deploy
# ...
#                       Apply complete! Resources: 2 imported, 0 added, 0 changed, 0 destroyed.
# 
# No outputs found.
```

インポートにより作成されたステートを確認する。

```bash
terraform state list \
  --state ./terraform.config-driven-import.tfstate
# aws_s3_bucket.bucket_cdktf-test-log-20231024_D553C520
# aws_s3_bucket.bucket_cdktf-test-web-20231024_957F5966
```

`importFrom`の呼び出しを削除する。

```typescript:main.ts
import { Construct } from "constructs";
import {
  App,
  TerraformStack,
} from "cdktf";

import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "ap-northeast-1",
    });

    new S3Buckets(
      this,
      "bucket",
      ["cdktf-test-web-20231024", "cdktf-test-log-20231024"]
    );
  }
}

// S3バケット
class S3Buckets extends Construct {
  constructor(scope: Construct, id: string, bucketNames: string[]) {
    super(scope, id);

    // すべてのバケット
    bucketNames.forEach((name) => {
-     new S3Bucket(this, name, {}).importFrom(name);
+     new S3Bucket(this, name, {});
    });
  }
}

const app = new App();
new MyStack(app, "config-driven-import");
app.synth();
```
