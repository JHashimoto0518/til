---
bibliography: 
repositoryUrl:
draft: true
---

# boto3-APIのメタデータを参照するには

CloudFormation ListStacks API の StackStatusFilter 列挙値を参照する例。

```python
# list_stacks()メソッドの定義を取得
operation_model = cfn_client.meta.service_model.operation_model("ListStacks")

# StackStatusFilterパラメータの定義を取得
stack_status_filter = operation_model.input_shape.members["StackStatusFilter"]
print(stack_status_filter.member.enum)
```

```python
def list_stacks(cloudformation_client, stack_status_filter: List[str] = []) -> List[str]:
  """CloudFormationスタックのサマリーを取得する。

  Args:
  cloudformation_client: boto3のCloudFormationクライアント。

  Returns:
  List[str]: CloudFormationスタックのサマリーのリスト。
  """
  stacks = []
  paginator = cloudformation_client.get_paginator("list_stacks")
    for page in paginator.paginate():
    for stack in page["StackSummaries"]:
    stacks.append(stack)

  return stacks
```