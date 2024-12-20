---
bibliography: 
  - https://repost.aws/knowledge-center/cloudfront-invalid-viewer-certificate
  - https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-requirements.html
  - https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-procedures.html
  - https://iret.media/9517
repositoryUrl:
draft: true
---

# CloudFrontに自己証明書を設定するには

```bash
openssl genrsa 2048 > server.key
(venv) ls -1
server.key
(venv) openssl req -new -x509 -days 3650 -key server.key -out server.crt
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:JP
State or Province Name (full name) [Some-State]:Tokyo
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Example Cooperation
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:www.example.com
Email Address []:
(venv) ls -12
ls: invalid option -- '2'
Try 'ls --help' for more information.
(venv) ls -1
server.crt
server.key
(venv) aws iam upload-server-certificate --path /cloudfront/ --server-certificate-name example-cert --certificate-body file://server.pem --private-key file://server.pem 

Error parsing parameter '--certificate-body': Unable to load paramfile file://server.pem: [Errno 2] No such file or directory: 'server.pem'
(venv) aws iam upload-server-certificate \
    --server-certificate-name example-cert \
    --certificate-body file://server.crt \
    --private-key file://server.key \
    --path /cloudfront/
{
    "ServerCertificateMetadata": {
        "Path": "/cloudfront/",
        "ServerCertificateName": "example-cert",
        "ServerCertificateId": "ASCAXYKJRS6MKNN5KIUUI",
        "Arn": "arn:aws:iam::533267060632:server-certificate/cloudfront/example-cert",
        "UploadDate": "2024-10-03T07:32:40+00:00",
        "Expiration": "2034-10-01T07:23:43+00:00"
    }
}
```

ディストリビューションに設定できない。

```bash
The specified SSL certificate doesn't exist, isn't in us-east-1 region, isn't valid, or doesn't include a valid certificate chain.
```

```bash
aws iam upload-server-certificate \
    --server-certificate-name example-cert \
    --certificate-body file://server.crt \
    --private-key file://server.key \
    --path /cloudfront/ \
    --region us-east-1
```

エラーは変わらず。

pathを "/cloudfront/production/"に変更してみる。

## retry

Perplexityより。

AWS CloudFrontの要件を満たす自己署名証明書を生成するには、以下の手順に従ってください:

1. プライベートキーの生成:
```
openssl genrsa -out private-key.pem 2048
```

2. 証明書署名要求(CSR)の作成:
```
openssl req -new -key private-key.pem -out csr.pem
```
このコマンドを実行すると、対話形式で情報の入力を求められます。Common Name (CN)には、CloudFrontディストリビューションのドメイン名を入力してください。

3. 自己署名証明書の生成:
```
openssl x509 -req -days 365 -in csr.pem -signkey private-key.pem -out certificate.pem
```

これらのコマンドで生成される証明書は以下の要件を満たします:

- X.509 PEM形式
- RSA 2048ビットキー
- パスワードで暗号化されていないプライベートキー
- 1年間有効（-daysオプションで調整可能）

注意点:

1. CloudFrontで使用する場合、証明書はus-east-1リージョンにアップロードする必要があります。

2. IAMにアップロードする際は、以下のコマンドを使用します:
```
aws iam upload-server-certificate \
    --server-certificate-name YourCertName \
    --certificate-body file://certificate.pem \
    --private-key file://private-key.pem \
    --path /cloudfront/ \
    --region us-east-1
```

3. 自己署名証明書はテスト環境でのみ使用してください。本番環境では、信頼された認証局(CA)から発行された証明書を使用することをお勧めします。

4. CloudFrontディストリビューションのドメイン名と証明書のCommon Name (CN)が一致していることを確認してください。

これらの手順に従うことで、CloudFrontの要件を満たす自己署名証明書を生成し、使用することができます。

Citations:
[1] https://docs.aws.amazon.com/ja_jp/AmazonCloudFront/latest/DeveloperGuide/cnames-and-https-requirements.html

Perplexityの応答にしたがい再試行したが、エラーは変わらず。

```bash
openssl genrsa -out private-key.pem 2048
```

```bash
openssl req -new -key private-key.pem -out csr.pem
```

```bash
Country Name (2 letter code) [AU]:JP
State or Province Name (full name) [Some-State]:TOKYO
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:example company
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:djdhoca8mq66n.cloudfront.net
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

```bash
openssl x509 -req -days 365 -in csr.pem -signkey private-key.pem -out certificate.pem
# Certificate request self-signature ok
# subject=C = JP, ST = TOKYO, O = example company, CN = djdhoca8mq66n.cloudfront.net
```

```bash
aws iam upload-server-certificate \
    --server-certificate-name YourCertName \
    --certificate-body file://certificate.pem \
    --private-key file://private-key.pem \
    --path /cloudfront/ \
    --region us-east-1
# {
#     "ServerCertificateMetadata": {
#         "Path": "/cloudfront/",
#         "ServerCertificateName": "YourCertName",
#         "ServerCertificateId": "ASCAXYKJRS6MIQLRZPML5",
#         "Arn": "arn:aws:iam::533267060632:server-certificate/cloudfront/YourCertName",
#         "UploadDate": "2024-10-03T23:56:51+00:00",
#         "Expiration": "2025-10-03T23:56:11+00:00"
#     }
# }
```

カスタムドメイン名で再試行したが、エラーは変わらず。

```bash
openssl req -new -key private-key.pem -out csr.pem
```

```bash
Country Name (2 letter code) [AU]:JP
State or Province Name (full name) [Some-State]:TOKYO
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:example company
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:www.jhashimoto.net                            
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
```

```bash
openssl x509 -req -days 365 -in csr.pem -signkey private-key.pem -out certificate.pem
# Certificate request self-signature ok
# subject=C = JP, ST = TOKYO, O = example company, CN = www.jhashimoto.net
```

```bash
aws iam upload-server-certificate \
    --server-certificate-name ExampleCert \
    --certificate-body file://certificate.pem \
    --private-key file://private-key.pem \
    --path /cloudfront/ \
    --region us-east-1
# {
#     "ServerCertificateMetadata": {
#         "Path": "/cloudfront/",
#         "ServerCertificateName": "ExampleCert",
#         "ServerCertificateId": "ASCAXYKJRS6MJGFRDYDAS",
#         "Arn": "arn:aws:iam::533267060632:server-certificate/cloudfront/ExampleCert",
#         "UploadDate": "2024-10-04T00:41:17+00:00",
#         "Expiration": "2025-10-04T00:40:01+00:00"
#     }
# }
```

## トラブルシューティング

Perplexityより。

このエラーメッセージは、CloudFrontで証明書を使用しようとする際によく発生します。問題を解決するために、以下の点を確認してください:

1. 証明書の存在:
   - IAMで証明書が正しくアップロードされているか確認してください。
   - `aws iam list-server-certificates` コマンドを使用して、アップロードされた証明書のリストを確認できます。

2. リージョン:
   - CloudFrontで使用する証明書は、必ずus-east-1リージョンにアップロードする必要があります。
   - 証明書をアップロードする際に、`--region us-east-1` オプションを使用してください。

3. 証明書の有効性:
   - 証明書の有効期限が切れていないか確認してください。
   - `aws iam get-server-certificate --server-certificate-name YourCertificateName` コマンドで証明書の詳細を確認できます。

4. 証明書チェーン:
   - 自己署名証明書を使用している場合、証明書チェーンは不要です。
   - 認証局（CA）発行の証明書を使用している場合、中間証明書を含む完全な証明書チェーンが必要です。

5. アップロード時のパス:
   - CloudFrontで使用する証明書は、`/cloudfront/` パスにアップロードする必要があります。
   - アップロード時に `--path /cloudfront/` オプションを使用してください。

6. 証明書とプライベートキーの形式:
   - 両方がPEM形式であることを確認してください。
   - プライベートキーが暗号化されていないことを確認してください。

7. 権限:
   - IAMユーザーに証明書の管理とCloudFrontの設定に必要な権限があることを確認してください。

これらの点を確認し、必要に応じて証明書を再アップロードしてみてください。問題が解決しない場合は、AWS CLIを使用して証明書の詳細を取得し、エラーの具体的な原因を特定することができます。

Citations:
[1] https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_server-certs.html
[2] https://supporthost.com/invalid-ssl-certificate/
[3] https://docs.aws.amazon.com/cli/latest/reference/iam/list-server-certificates.html
[4] https://docs.aws.amazon.com/cli/latest/reference/iam/get-server-certificate.html
