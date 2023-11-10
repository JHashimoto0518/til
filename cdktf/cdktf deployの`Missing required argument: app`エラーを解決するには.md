# cdktf deployの`Missing required argument: app`エラーを解決するには

`cdktf deploy`でエラー。

```bash
cdktf deploy --var 'bucket_names=["cdktf-test-web-20231024","cdktf-test-lo
g-20231024"]'
# Missing required argument: app
```

`.ts`では Variable を宣言していたが、`cdk.tf.json`が更新されていないため、宣言が反映されていなかった。

合成で、エラーは解消された。

```bash
cdktf synth

# Generated Terraform code for the stacks: config-driven-import
```

合成後の`cdk.tf.json`より抜粋。

```json:/cdktf.out/stacks/config-driven-import/cdk.tf.json
  "variable": {
    "bucket_names": {
      "type": "list(string)"
    }
  }
```
