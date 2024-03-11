---
bibliography: 
repositoryUrl:
draft: true
---

# jsonをcsvに変換するには

RDS の DB パラメータを CSV で出力する例。

## ヘッダなし

```bash
aws rds describe-db-cluster-parameters --db-cluster-parameter-group-name default.aurora-postgresql13 | jq -r '.Parameters[] | [.ParameterName, .Description, .Source, .ApplyType, .DataType, .AllowedValues, .IsModifiable] | @csv' | head -1
# "ansi_constraint_trigger_ordering","Change the firing order of constraint triggers to be compatible with the ANSI SQL standard.","engine-default","dynamic","boolean","0,1",true
```

エンコードを避けるため `-r` を付けること。

`-r` なしの出力例。

```bash
aws rds describe-db-cluster-parameters --db-cluster-parameter-group-name default.aurora-postgresql13 | jq '.Parameters[] | [.ParameterName, .Description, .Source, .ApplyType, .DataType, .AllowedValues, .IsModifiable] | @csv' | head -1
# "\"ansi_constraint_trigger_ordering\",\"Change the firing order of constraint triggers to be compatible with the ANSI SQL standard.\",\"engine-default\",\"dynamic\",\"boolean\",\"0,1\",true"
```

## ヘッダ付き

https://stackoverflow.com/questions/30015555/how-to-add-a-header-to-csv-export-in-jq

ハードコードでヘッダを指定する。

```bash
aws rds describe-db-cluster-parameters --db-cluster-parameter-group-name default.aurora-postgresql13 | jq -r '["ParameterName", "Description", "Source", "ApplyType", "DataType", "AllowedValues", "IsModifiable"], ( .Parameters[] | [.ParameterName, .Description, .Source, .ApplyType, .DataType, .AllowedValues, .IsModifiable]) | @csv' | head -2
# "ParameterName","Description","Source","ApplyType","DataType","AllowedValues","IsModifiable"
# "ansi_constraint_trigger_ordering","Change the firing order of constraint triggers to be compatible with the ANSI SQL standard.","engine-default","dynamic","boolean","0,1",true
```

動的にヘッダを生成する。

参考。

```bash
map({message: .commit.message, name: .commit.committer.name}) | (.[0] | to_entries | map(.key)), (.[] | [.[]]) | @csv
```
