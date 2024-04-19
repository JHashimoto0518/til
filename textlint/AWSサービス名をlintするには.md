---
bibliography: 
   - https://dev.classmethod.jp/articles/create_aws_textlint_rule/
repositoryUrl:
draft: false
---

# AWSサービス名をlintするには

https://github.com/bun913/textlint-rule-aws-service-name

ルールをインストールしてから、`.textlintrc.json` を作成する。

```bash
npm install textlint-rule-aws-service-name --save-dev
```

```bash
npx textlint --init
# .textlintrc.json is created.
```
