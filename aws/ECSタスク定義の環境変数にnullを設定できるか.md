---
bibliography: 
    - https://qiita.com/tcsh/items/7720d0cdf297628f2d95
    - https://zenn.dev/kirimaru/articles/cb631b1b848e86
    - https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definition_environment
    - https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ecs/register-task-definition.html
repositoryUrl:
draft: false
---

# ECSタスク定義の環境変数にnullを設定できるか

JSON の仕様では、`null` の使用が許可されている。

https://www.rfc-editor.org/rfc/rfc8259

<pre>
A JSON value MUST be an object, array, number, or string, or one of the following three literal names:

      false
      null
      true
</pre>

コンテナ定義の環境変数に `null` を使用できるか検証する。

変数に JSON ファイル名を設定しておく。

```bash
FILE_ECS_TASK_DEFINITION='sleep360.json'
```

`null`の環境変数を定義した JSON ファイルを出力する。

```bash
cat << EOF > ${FILE_ECS_TASK_DEFINITION}
> {
>         "containerDefinitions": [
>           {
>             "name": "sleep",
>             "image": "busybox",
>             "cpu": 10,
>             "command": [
>               "sleep",
>               "360"
>             ],
>             "memory": 10,
>             "essential": true,
>             "environment" : [
>                 { "name" : "env1", "value" : null }
>             ]
>           }
>         ],
>         "family": "sleep360"
> }
> EOF
```

型不正エラーで、登録できない。

```bash
aws ecs register-task-definition --cli-input-json file://${FILE_ECS_TASK_DEFINITION}
# 
# Parameter validation failed:
# Invalid type for parameter containerDefinitions[0].environment[0].value, value: None, type: <class 'NoneType'>, valid types: <class 'str'>
```

なお、空文字列であれば、登録可能。

```bash
cat << EOF > ${FILE_ECS_TASK_DEFINITION}
> {
>         "containerDefinitions": [
>           {
>             "name": "sleep",
>             "image": "busybox",
>             "cpu": 10,
>             "command": [
>               "sleep",
>               "360"
>             ],
>             "memory": 10,
>             "essential": true,
>             "environment" : [
>                 { "name" : "env1", "value" : "" }
>             ]
>           }
>         ],
>         "family": "sleep360"
> }
> EOF
```

```bash
aws ecs register-task-definition --cli-input-json file://${FILE_ECS_TASK_DEFINITION}
# {
#     "taskDefinition": {
#         ...
#                 "environment": [
#                     {
#                         "name": "env1",
#                         "value": ""
#                     }
#                 ],
#         ...
#     }
# }
```
