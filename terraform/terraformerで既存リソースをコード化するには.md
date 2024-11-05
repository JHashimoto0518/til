---
bibliography: 
repositoryUrl:
draft: true
---

# terraformerで既存リソースをコード化するには

generated compaction:

```bash
terraformer import aws \
  --compact \
  --resources=* \
  --regions=ap-northeast-1 \
  --profile=xxxxx
```

generated no service directory:

```bash
terraformer import aws \
  --path-pattern {output} \
  --resources=* \
  --regions=ap-northeast-1 \
  --profile=xxxxx
```
