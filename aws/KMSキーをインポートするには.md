---
bibliography: 
    - https://docs.aws.amazon.com/ja_jp/kms/latest/developerguide/importing-keys.html
    - https://dev.classmethod.jp/articles/kms-import-key-material/
repositoryUrl:
draft: false
publish: false
---

# KMSキーをインポートするには

カスタマーマスターキーを作成する。

https://docs.aws.amazon.com/ja_jp/kms/latest/developerguide/importing-keys-create-cmk.html

```bash
aws kms create-key --origin EXTERNAL --description imported_key
{
    "KeyMetadata": {
        "AWSAccountId": "<account id>",
        "KeyId": "<your key id>",
        "Arn": "arn:aws:kms:ap-northeast-1:<account id>:key/<your key id>",
        "CreationDate": "2024-01-09T06:05:17.814000+00:00",
        "Enabled": false,
        "Description": "imported_key",
        "KeyUsage": "ENCRYPT_DECRYPT",
        "KeyState": "PendingImport",
        "Origin": "EXTERNAL",
        "KeyManager": "CUSTOMER",
        "CustomerMasterKeySpec": "SYMMETRIC_DEFAULT",
        "KeySpec": "SYMMETRIC_DEFAULT",
        "EncryptionAlgorithms": [
            "SYMMETRIC_DEFAULT"
        ],
        "MultiRegion": false
    }
}
```

```bash
KEY_ID="<your key id>"
echo $KEY_ID 
# <your key id>
```

公開鍵とインポートトークンをダウンロードする。

https://docs.aws.amazon.com/ja_jp/kms/latest/developerguide/importing-keys-get-public-key-and-token.html#importing-keys-get-public-key-and-token-api

公式ドキュメントに記載されたコマンドを実行すると、エラーが発生する。

```bash
aws kms get-parameters-for-import \
    --key-id $KEY_ID \
    --wrapping-algorithm RSA_AES_KEY_WRAP_SHA_256 \
    --wrapping-key-spec RSA_3072
# 
# An error occurred (ValidationException) when calling the GetParametersForImport operation: Wrapping algorithm RSA_AES_KEY_WRAP_SHA_256 and wrapping key spec RSA_3072 cannot be used to # import a SYMMETRIC_DEFAULT key.
```

ラップアルゴリズム `RSA_AES_KEY_WRAP_SHA_256` は、対称鍵をサポートしていないため。対称鍵をサポートするラップアルゴリズムで再試行する。ついでに、キー仕様を推奨値の `RSA_4096` に変更する。

```bash
aws kms get-parameters-for-import \
    --key-id $KEY_ID \
    --wrapping-algorithm RSAES_OAEP_SHA_256 \
    --wrapping-key-spec RSA_4096
{
    "KeyId": "arn:aws:kms:ap-northeast-1:<account id>:key/<your key id>",
    "ImportToken": "AQEC...",
    "PublicKey": "MIIC...==",
    "ParametersValidTo": "2024-01-10T06:26:34.421000+00:00"
}
```

`PublicKey` をペーストし、`PublicKey.b64` として保存する。

```bash
echo "MIICI...==" > PublicKey.b64
```

`ImportToken` をペーストし、`importtoken.b64` として保存する。

```bash
echo "AQEC..." > importtoken.b64
```

PublicKey を base64 でデコードし、WrappingPublicKey.bin に保存する。

```bash
# -d: デコード, -A: Base64バッファを単一の行として指定
openssl enc -d -base64 -A -in PublicKey.b64 -out WrappingPublicKey.bin
```

インポートトークンを base64でデコードし、ImportToken.binに保存する。

```bash
openssl enc -d -base64 -A -in importtoken.b64 -out ImportToken.bin
```

テスト用のキーマテリアルを、256 ビット対称キー (32 バイトのランダム文字列) で作成する。

https://docs.aws.amazon.com/ja_jp/kms/latest/developerguide/importing-keys-encrypt-key-material.html

```bash
openssl rand -out PlaintextKeyMaterial.bin 32
```

ダウンロードした公開鍵でキーマテリアルを暗号化する。

```bash
# -keyform: 秘密鍵のフォーマット, -pubin: 入力は公開鍵
openssl pkeyutl \
    -encrypt \
    -in PlaintextKeyMaterial.bin \
    -out EncryptedKeyMaterial.bin \
    -inkey WrappingPublicKey.bin \
    -keyform DER \
    -pubin \
    -pkeyopt rsa_padding_mode:oaep \
    -pkeyopt rsa_oaep_md:sha256 \
    -pkeyopt rsa_mgf1_md:sha256
```

ChatGPTによる、`-pkeyopt` の説明。

```Text
-pkeyopt オプションは、公開鍵操作に対する追加パラメータを設定するために使用されます。

rsa_padding_mode:oaep: RSA 暗号化のためのパディングモードを OAEP (Optimal Asymmetric Encryption Padding) に設定します。OAEP は、メッセージの暗号化をより安全に行うためのパディングスキームです。

rsa_oaep_md:sha256: OAEP パディングで使用されるメッセージダイジェストアルゴリズムを SHA-256 に設定します。これは、メッセージのハッシュ化に使用されるアルゴリズムです。

rsa_mgf1_md:sha256: MGF1 (Mask Generation Function 1) で使用されるハッシュ関数を SHA-256 に設定します。MGF1 は OAEP パディングの一部として使用される関数で、メッセージのセキュリティを強化します。
```

キーマテリアルをインポートする。

https://docs.aws.amazon.com/ja_jp/kms/latest/developerguide/importing-keys-import-key-material.html

```bash
# 有効期限は、リクエストの時点から 365 日後までを設定できる
VALID_TO="2025-01-01T00:00:00Z"
```

```bash
aws kms import-key-material --key-id $KEY_ID \
    --encrypted-key-material fileb://EncryptedKeyMaterial.bin \
    --import-token fileb://ImportToken.bin \
    --expiration-model KEY_MATERIAL_EXPIRES \
    --valid-to $VALID_TO
```

ステータスが `Enabled` になり、有効期限が設定されたことを確認する。

```bash
aws kms describe-key --key-id $KEY_ID
```
output:

```json
{
    "KeyMetadata": {
        "AWSAccountId": "<account id>",
        "KeyId": "<your key id>",
        "Arn": "arn:aws:kms:ap-northeast-1:<account id>:key/<your key id>",
        "CreationDate": "2024-01-09T06:05:17.814000+00:00",
        "Enabled": true,
        "Description": "imported_key",
        "KeyUsage": "ENCRYPT_DECRYPT",
        "KeyState": "Enabled",
        "ValidTo": "2025-01-01T00:00:00+00:00",
        "Origin": "EXTERNAL",
        "ExpirationModel": "KEY_MATERIAL_EXPIRES",
        "KeyManager": "CUSTOMER",
        "CustomerMasterKeySpec": "SYMMETRIC_DEFAULT",
        "KeySpec": "SYMMETRIC_DEFAULT",
        "EncryptionAlgorithms": [
            "SYMMETRIC_DEFAULT"
        ],
        "MultiRegion": false
    }
}
```
