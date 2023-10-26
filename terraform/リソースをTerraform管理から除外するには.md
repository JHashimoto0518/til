# リソースをTerraformの管理から除外するには

stateをローカルで管理している場合。

```bash
terraform state list --state ./terraform.config-driven-import.tfstate
# aws_s3_bucket.cdktf-test-log-20231024
```

```bash
terraform state rm --state ./terraform.config-driven-import.tfstate aws_s3_bucket.cdktf-test-log-20231024
# Removed aws_s3_bucket.cdktf-test-log-20231024
# Successfully removed 1 resource instance(s).
```