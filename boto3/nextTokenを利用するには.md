---
bibliography: 
    - https://qiita.com/noid11/items/c2d9f9213e92a0f5ee4b
repositoryUrl:
    - https://github.com/...
draft: true
---

# nextTokenを利用するには

```python
import boto3

client = boto3.client("logs")
response = client.describe_log_groups()

print(response)
print("end first response")
print("Next token: " + response["nextToken"])

print("start next token loop")
while "nextToken" in response:
    response = client.describe_log_groups(nextToken=response["nextToken"])
    print(response)
```