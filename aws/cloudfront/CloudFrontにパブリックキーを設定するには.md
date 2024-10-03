---
bibliography: 
  - https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/private-content-trusted-signers.html
repositoryUrl:
draft: false
---

# CloudFrontにパブリックキーを設定するには

キーペアを作成する。

```bash
openssl genrsa -out private_key.pem 2048
```

キーペアから公開鍵を抽出する。

```bash
openssl rsa -pubout -in private_key.pem -out public_key.pem
```

```bash
ls -1 | grep .pem
# private_key.pem
# public_key.pem
```

公開鍵の中身を確認する。

```bash
cat public_key.pem 
# -----BEGIN PUBLIC KEY-----
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsa6AEg04RizdY1tbY+Dp
# HAQob5H7DfNFvLEF+bDhPp0cvxSOML+aZ5paEKqX7qgxCGgmD2DpKy+3zhzFePVH
# JFLjl4+PW/hY+EzBtpCcYEoiImdXDHUUOJOjgEmkc3JJ76qR4Csxmw70DqWoTxYv
# 3FrQBbVOsio/S/mrY0YIiOES07ng48tcD7CYY8TGRXeFJyUzVnS/igozoX82NTPu
# TS4e2Mn3IBRs8S15NwC5hlV5n8U3ko3ct+H6GpjaijzTebnpLKhXCN+G/a8rNKf9
# u6Hj/2g1MnKykkoHoKo4U2hNG9Ph/jJbIR3GgcaRTI0OsSdbh5UmaPrelyUOo/zG
# 7wIDAQAB
# -----END PUBLIC KEY-----
```

作成した公開鍵をCloudFrontに設定する。
