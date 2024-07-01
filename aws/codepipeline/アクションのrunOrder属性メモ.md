---
bibliography: 
repositoryUrl:
draft: false
---

# アクションのrunOrder属性メモ

https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/reference-pipeline-structure.html

実行順序 (`runOrder`) はステージ内のアクションの実行順序を決定する。

> 例えば、3 つのアクションをステージのシーケンスで実行する場合、最初のアクションの runOrder 値には 1 を、2 番目のアクションの runOrder 値には 2 を、3 番目のアクションの runOrder 値には 3 を指定します。ただし、2 番目と 3 番目のアクションを並列に実行する場合、最初のアクションの runOrder 値には 1 を、2 番目と 3 番目のアクションの runOrder 値にはいずれも 2 を指定します。

1 オリジンでなくてもよい。

> アクションの runOrder のデフォルト値は 1 です。値は、正の整数 (自然数) にする必要があります。

厳密なシーケンスでなくてもよい。

> シリアルアクションの番号付けは、厳密なシーケンスである必要はありません。例えば、シーケンスに 3 つのアクションがあり、2 番目のアクションを削除する場合、3 番目のアクションの runOrder 値の番号付けをやり直す必要はありません。アクション (3) の runOrder の値は、最初のアクション (1) の runOrder の値より大きいため、ステージの最初のアクションが実行されてから順番に実行されます。
