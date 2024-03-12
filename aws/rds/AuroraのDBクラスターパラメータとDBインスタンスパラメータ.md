---
bibliography: 
repositoryUrl:
draft: true
---

# AuroraのDBクラスターパラメータとDBインスタンスパラメータ

https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/AuroraUserGuide/USER_WorkingWithDBClusterParamGroups.html#Aurora.Managing.ParameterGroups

- 変更した DB パラメータ設定は、構成設定を変更してデフォルト値に戻した場合でも、DB クラスターパラメータグループ値より優先される
- オーバーライドされるパラメーターは、Source フィールドで判別できる。該当するパラメータを変更した場合、値が user になる

## Q. instance に複数パラメータグループを設定できるか？

A. instance には、複数パラメータグループを設定できない

## Q. クラスターとインスタンスに異なるパラメータグループが設定されている場合に、instance の DBParameterGroups には、クラスターの ParameterGroup も返却されるか？

A. 返却されない

## Q. API レスポンスで、複数のパラメータグループが返却されることはあるか？

A. 先の Answer より「ない」と思われる

## Q. クラスターパラメータに存在しないインスタンスパラメータはあるか？

A. 引用より、インスタンスパラメータにはデフォルト値としてクラスターパラメータが存在し、例外はないと考えられる。

> すべての Aurora クラスターは、DB クラスターパラメータグループに関連付けられます。このパラメータグループは、対応する DB エンジンの**すべての設定値**にデフォルト値を割り当てます。クラスターパラメータグループには、クラスターレベルとインスタンスレベル両方のパラメータのデフォルトも含まれています。
>
> 各 DB インスタンスにも DB パラメータグループが関連付けられます。DB パラメータグループの値によって、クラスターパラメータグループのデフォルト値をオーバーライドできます。

- [ ] Diff を添付する
  
クラスターパラメータとインスタンスパラメータの比較結果から裏付けられる。

## Q. パラメータsourceフィールドの意味は？

`source`は、値のソースを示す。

`engine-default`: データベースエンジンのデフォルト値。

例えば、PostgreSQL 13 `autovacuum_vacuum_cost_delay` のデフォルト値は 2 である。

https://www.postgresql.jp/document/13/html/runtime-config-autovacuum.html

`system`: RDS サービスのデフォルト値。コンピューティングクラスおよびインスタンンスの割り当てストレージにより決まる。

`user`: ユーザーがパラメータを変更したことを示す。変更したパラメータをデフォルト値に戻しても、`user`のままなので注意すること。

## 参考

https://stackoverflow.com/questions/46719707/how-to-see-default-mysql-parameter-values-of-aws-mysql-rds-instance-on-aws-conso

https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/parameter-groups-overview.html#parameter-groups-overview.custom

> デフォルトの各パラメータグループには、エンジン、コンピューティングクラス、およびインスタンスの割り当てストレージに基づいた、データベースエンジンのデフォルトと Amazon RDS システムのデフォルトが含まれています。

## 表記の違い

Source の表記の違い。

|                    | エンジンのデフォルト | システムのデフォスト | ユーザー   |
| ------------------------ | -------------------- | -------------------- | ---------- |
| API Response             | `engine-default`     | `system`             | `user`     |
| マネージメントコンソール | `Engine default`     | `System default`     | `Modified` |

## Q. パラメータの優先順位は？

| ケース | クラスターパラメータ | インスタンスパラメータ | 適用されるパラメータ   |
| ------ | -------------------- | ---------------------- | ---------------------- |
| 1      | デフォルト[^1]       | パラメータなし         | デフォルト             |
| 2      | デフォルト           | デフォルト             | デフォルト             |
| 3      | デフォルト           | `user`                 | インスタンスパラメータ |
| 4      | `user`               | デフォルト             | クラスターパラメータ   |
| 5      | `user`               | `user`                 | インスタンスパラメータ |

[^1]: `engine-default`, `system` を「デフォルト」と記載

参考: https://dev.classmethod.jp/articles/aurora-parameter-group-priority/
