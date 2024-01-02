---
bibliography:
repositoryUrl:
    - https://github.com/JHashimoto0518/power-query-exercise/blob/main/get-csvpath-from-book.pq
draft: false
---

# Excelシートにデータソースのファイルパスを保持するには

セルに `CsvPath` の名前を付け、CSV ファイルのパスを入力しておく。

クエリを作成する。

```fsharp
let
    // Excelブックに定義された名前 CsvPath から テーブルを取得
    csvPathTable = Excel.CurrentWorkbook(){[Name = "CsvPath"]}[Content],
    // テーブルの Column1 列の行をリスト化
    pathList = Table.Column(csvPathTable, "Column1"),
    // リストの先頭の要素を取得
    csvPath = pathList{0}
in
    csvPath
```
