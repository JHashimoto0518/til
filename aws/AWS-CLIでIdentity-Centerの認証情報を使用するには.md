---
bibliography: 
  - https://aws.amazon.com/jp/builders-flash/202306/handle-aws-cli/
repositoryUrl:
draft: false
---

# AWS-CLIでIdentity-Centerの認証情報を使用するには

`aws configure sso` を実行し、必要な情報を入力していく。ブラウザでのサインインや認証コード入力も求められる。

```bash
aws configure sso
# SSO start URL [None]: https://d-1234567890.awsapps.com/start/
# SSO Region [None]: ap-northeast-1
# Attempting to automatically open the SSO authorization page in your default browser.
# If the browser does not open or you wish to use a different device to authorize this request, open the following URL:
# 
# https://device.sso.ap-northeast-1.amazonaws.com/
# 
# Then enter the code:
# 
# DSCD-xxxx
# ...
# xdg-open: no method available for opening 'https://device.sso.ap-northeast-1.amazonaws.com/?user_code=DSCD-xxxx'
```

アカウントの候補が複数存在する場合は、いずれかを選択する。

```bash
# There are 2 AWS accounts available to you.
# Using the account ID 123456789012
# The only role available to you is: AWSAdministratorAccess
# Using the role name "AWSAdministratorAccess"
```

さらに必要な情報を入力していく。

```bash
# CLI default client Region [None]: ap-northeast-1
# CLI default output format [None]:
# CLI profile name [AWSAdministratorAccess-123456789012]:
# ...
```

設定は `~/.aws/config` に書き込まれる。

```text
[profile AWSAdministratorAccess-123456789012]
sso_start_url = https://d-1234567890.awsapps.com/start/
sso_region = ap-northeast-1
sso_account_id = 123456789012
sso_role_name = AWSAdministratorAccess
region = ap-northeast-1
```
