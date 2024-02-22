---
bibliography: 
repositoryUrl:
draft: true
---

# SBOMによるソフトウェア利用状況監視をAWSで構築する

Dependency-Track を導入すればできそう。Dependency-Track は、コンポーネント分析プラットフォーム。

Dependency-Track は、CycloneDX をサポートしている。

https://docs.dependencytrack.org/

その他の記事。

- https://qiita.com/prt445/items/16a6e6b3f7e51f474f9c
- https://blog.cloudtechner.com/sbom-continuous-analysis-with-dependencytrack-59f759af6472

Inspector も CycloneDX をサポートしている。

https://docs.aws.amazon.com/ja_jp/inspector/latest/user/sbom-export.html

- Amazon Inspector では、CycloneDX 1.4 および SPDX 2.3 互換フォーマットでの SBOM のエクスポートをサポートしている
- Amazon Inspector では、選択した Amazon S3 バケットに SBOM を JSON ファイルとしてエクスポートする

SBOM ではないが、AWS で DevSecOps のパイプラインを構築する例。

https://aws.amazon.com/jp/blogs/devops/building-end-to-end-aws-devsecops-ci-cd-pipeline-with-open-source-sca-sast-and-dast-tools/

Dependency-Track に、CycloneDX の SBOM を put する例。

https://docs.dependencytrack.org/usage/cicd/

```bash
curl -X "PUT" "http://dtrack.example.com/api/v1/bom" \
     -H 'Content-Type: application/json' \
     -H 'X-API-Key: LPojpCDSsEd4V9Zi6qCWr4KsiF3Konze' \
     -d $'{
  "project": "f90934f5-cb88-47ce-81cb-db06fc67d4b4",
  "bom": "PD94bWwgdm..."
}'
```

以下は案。

初期構築として、Dependency-Track を Docker Compose する。利用するのは、ECS, EC2, App Runner あたり？

1. Inspector で S3 バケットに SBOM をエクスポート
2. バケットへのエクスポートをトリガーに、Dependency-Track API をキックする

AWS ではないが、Dependency-Track を使用した自動プロジェクト追跡の事例。Dependency-Track API を使用して、成果物ビルドの際に SBOM を更新している。

https://itnext.io/a-practical-approach-to-sbom-in-ci-cd-part-iii-tracking-sboms-with-dependency-track-fb5621d135ba
