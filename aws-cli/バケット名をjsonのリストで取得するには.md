---
bibliography: 
repositoryUrl:
draft: false
---

# バケット名をjsonのリストで取得するには

```bash
aws s3api list-buckets --output json | jq -c .
# ["tf-bulk-import-test-1","tf-bulk-import-test-2","tf-bulk-import-test-3"]
```

jq の `-c` オプションで、整形せずに 1 行で出力される。

```bash
jq --help
# ...
# Some of the options include:
#   -c               compact instead of pretty-printed output;
# ...
```
