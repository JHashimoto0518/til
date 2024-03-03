---
bibliography: 
repositoryUrl:
  - https://github.com/JHashimoto0518/python-exercise/blob/main/boto3/nexttoken-sample.py
draft: true
---

# describe_image_scan_findingsでScanNotFoundExceptionを回避するには

## 事象

スキャン結果の取得を試みると、例外が発生する。

## 調べたこと

https://botocore.amazonaws.com/v1/documentation/api/latest/reference/services/ecr/client/exceptions/ScanNotFoundException.html

> The specified image scan could not be found. Ensure that image scanning is enabled on the repository and try again.

## エラーメッセージ

```bash
botocore.errorfactory.ScanNotFoundException: An error occurred (ScanNotFoundException) when calling the DescribeImageScanFindings operation: Image scan does not exist for the image with '{imageDigest:'...', imageTag
:'null'}' in the repository with name '<repository-name>' in the registry with id '<registry-name>'
```
