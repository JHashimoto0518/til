---
bibliography: 
  - https://www.udemy.com/course/power-query-jp/
repositoryUrl:
draft: true
---

# Excel＆Power-BI両方で使えるPower-Query完全ガイド

## セクション9: M言語の基本

### カスタム関数の基礎

足し算の例。

```fsharp
(a as number, b as number) => a + b
```

let で式を作成し、in で return する例。

```fsharp
(score as number) =>
let
  result = ...
in
  result
```

テスト方法。

1. データの入力で、テストデータを入力する
2. カスタム列にカスタム関数を適用する

## セクション10: 知っておきたいテクニック

### エラーが起こりにくいクエリの作成

型変換のタイミング。

- できるだけ最後に行う。カラムの削除・変更によりエラーになるケースを減らすため。
- 先に行・列を削除する。無駄な処理を減らすため。

### 2 つのデータの比較

同一ブックに対象シートを読み込み、結合の条件で、一致行もしくは一致しない行をフィルタリングする。
