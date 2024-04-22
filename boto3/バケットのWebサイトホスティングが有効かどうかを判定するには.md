---
bibliography: 
repositoryUrl:
draft: false
---

# バケットのWebサイトホスティングが有効かどうかを判定するには

```python
import boto3
from botocore.exceptions import ClientError

def check_s3_website_configuration(bucket_name):
    s3 = boto3.client('s3')

    try:
        response = s3.get_bucket_website(Bucket=bucket_name)
        return True
    except ClientError as e:
        # NOTE: botocore.exceptions.ClientError: An error occurred (NoSuchWebsiteConfiguration) when calling the GetBucketWebsite operation: The specified bucket does not have a website configuration
        if e.response['Error']['Code'] == 'NoSuchWebsiteConfiguration':
            return False

        raise e

# バケット名を指定
bucket_name = 'your-bucket-name'
check_s3_website_configuration(bucket_name)
```
