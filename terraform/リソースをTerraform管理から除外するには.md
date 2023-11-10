# リソースをTerraformの管理から除外するには

state をローカルで管理している場合。

## ステートを削除する

```bash
terraform state list \
  --state ./terraform.config-driven-import.tfstate
# aws_s3_bucket.cdktf-test-log-20231024
```

```bash
terraform state rm \
  --state ./terraform.config-driven-import.tfstate \
  aws_s3_bucket.cdktf-test-log-20231024
# Removed aws_s3_bucket.cdktf-test-log-20231024
# Successfully removed 1 resource instance(s).
```

## for-eachで作成したリソースのステートを削除する

ダブルクォーテーションが含まれたリソース名を指定すると、削除に失敗する。

```bash
terraform state rm \
  --state ./terraform.config-driven-import.tfstate \
  aws_s3_bucket.bucket["cdktf-test-log-20231024"]
# ╷
# │ Error: Index value required
# │ 
# │   on  line 1:
# │   (source code not available)
# │ 
# │ Index brackets must contain either a literal number or a literal string.
# ╵
```

エスケープすると、成功する。

```bash
terraform state rm \
  --state ./terraform.config-driven-import.tfstate \
  aws_s3_bucket.bucket[\"cdktf-test-log-20231024\"]
# Removed aws_s3_bucket.bucket["cdktf-test-log-20231024"]
# Successfully removed 1 resource instance(s).
```