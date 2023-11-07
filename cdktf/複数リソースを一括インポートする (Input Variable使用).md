# 複数リソースを一括インポートする (Input Variable使用)

```typescript:main.ts
import { Construct } from "constructs";
import { App, TerraformIterator, TerraformStack, TerraformVariable, VariableType } from "cdktf";
import { AwsProvider } from "@cdktf/provider-aws/lib/provider";
import { S3Bucket } from "@cdktf/provider-aws/lib/s3-bucket";

class MyStack extends TerraformStack {
  constructor(scope: Construct, id: string) {
    super(scope, id);

    new AwsProvider(this, "AWS", {
      region: "ap-northeast-1",
    });

    const bucketNames = new TerraformVariable(this, "bucket_names", {
      type: VariableType.list(VariableType.STRING),
      default: ["cdktf-test-web-20231024", "cdktf-test-log-20231024"],
    });

    const simpleIterator = TerraformIterator.fromList(bucketNames.listValue);

    // すべてのバケットに対してインポートを実行
    new S3Bucket(this, "bucket", {
      forEach: simpleIterator,
    }).importFrom(simpleIterator.value);
  }
}

const app = new App();
new MyStack(app, "config-driven-import");
app.synth();
```

List 型の Variable を参照するには、イテレータを利用する。

https://developer.hashicorp.com/terraform/cdktf/concepts/iterators

期待と異なり、インポートではなく、Create する plan が出力された。

```bash
$ cdktf diff
...

                      Terraform will perform the following actions:
config-driven-import    # aws_s3_bucket.bucket (bucket)["cdktf-test-log-20231024"] will be created
                        + resource "aws_s3_bucket" "bucket" {
                            + acceleration_status         = (known after apply)
...
                          }

                        # aws_s3_bucket.bucket (bucket)["cdktf-test-web-20231024"] will be created
                        + resource "aws_s3_bucket" "bucket" {
                            + acceleration_status         = (known after apply)
...
                          }

                      Plan: 2 to add, 0 to change, 0 to destroy.
                      
                      ─────────────────────────────────────────────────────────────────────────────

                      Saved the plan to: plan

                      To perform exactly these actions, run the following command to apply:
                          terraform apply "plan"
```

インポートブロックが、まだ for-each をサポートしていないからでは？

https://twitter.com/Tocyuki/status/1717160934047879172

https://github.com/hashicorp/terraform/pull/33932
