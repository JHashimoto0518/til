---
bibliography: 
repositoryUrl:
draft: false
---

# drawioでインポートするCSVの仕様

## 公式ブログ

書式設定オプションの説明。

https://drawio-app.com/blog/automatically-create-draw-io-diagrams-from-csv-files/

https://www.drawio.com/blog/insert-from-csv

## QA

Google グループの QA より引用。

https://groups.google.com/g/drawio/c/caj3ofvScq4

The same style options are available as for draw.io itself. You can find some guidelines here:

https://desk.draw.io/support/solutions/articles/16000067798-how-to-customize-shapes-

But generally you can find lots of info here:

https://desk.draw.io/support/solutions

> For selecting arrow style, start draw.io, apply the arrow you prefer to an edge. Then look at the style and find the start/endArrow style value.
>
> Instead of straight=1 write curved=0, or completely remove curved, default is 0.
>
> You color edges (connectors) the same as stencils (fillColor and strokeColor).

訳。

draw.io 自体と同じスタイル オプションを使用できます。いくつかのガイドラインについては、以下を参照してください。

https://desk.draw.io/support/solutions/articles/16000067798-how-to-customize-shapes-

しかし、一般的には、ここで多くの情報を見つけることができます。

https://desk.draw.io/support/solutions

矢印のスタイルを選択するには、draw.io から始めて、好みの矢印をエッジに適用します。次に、スタイルを見て、start/endArrow スタイルの値を見つけます。

straight=1 の代わりに curved=0 と書くか、curved を完全に削除するか、デフォルトは 0 です。

エッジ (コネクタ) の色は、ステンシル (fillColor と strokeColor) と同じです。

## QAへの返信

この QA への返信。

> Here is a list of all the styles (starting with STYLE_): https://jgraph.github.io/mxgraph/docs/js-api/files/util/mxConstants-js.html#mxConstants Also try https://support.draw.io/display/DOB/2016/04/28/draw.io+Cell+Styles - there are some additional ones like childLayout, html, container, connectable, collapsible, noJump, snapToPoint, comic and others that are specific to draw.io.

訳。

以下は、すべてのスタイルのリストです(STYLE_で始まります)。 https://jgraph.github.io/mxgraph/docs/js-api/files/util/mxConstants-js.html#mxConstants また、https://support.draw.io/display/DOB/2016/04/28/draw.io+Cell+Styles を試してください - childLayout、html、container、connectable、collapsible、noJump、snapToPoint、comic など、draw.io に固有のものがいくつかあります。

## CSVサンプルの説明コメント

CSV サンプルに説明のコメントがある。

https://github.com/jgraph/drawio-diagrams/tree/dev/examples/csv

CSV サンプルの説明。`Habit Tracker app AWS diagram` についての説明もある。

https://drawio-app.com/blog/import-from-csv-to-drawio/

```Text
## Habit Tracker app AWS diagram
# label: %component%
# style: shape=%shape%;fillColor=%fill%;strokeColor=%stroke%;verticalLabelPosition=bottom;
# namespace: csvimport-
# connect: {"from":"refs", "to":"id", "invert":true, "style":"curved=0;endArrow=none;endFill=0;dashed=1;strokeColor=#6c8ebf;"}
# width: 80
# height: 80
# ignore: id,shape,fill,stroke,refs
# nodespacing: 40
# levelspacing: 40
# edgespacing: 40
# layout: horizontaltree
## CSV data starts below this line
id,component,fill,stroke,shape,refs
1,Habit Tracker HTML App,#ffe6cc,#d79b00,mxgraph.aws4.mobile,
2,UI Assets,#277116,#ffffff,mxgraph.aws4.s3,1
3,User Authentication,#C7131F,#ffffff,mxgraph.aws4.cognito,1
4,API Gateway,#5A30B5,#ffffff,mxgraph.aws4.api_gateway,1
5,AWS Lambda,#277116,none,mxgraph.aws4.lambda_function,4
6,Database,#3334B9,#ffffff,mxgraph.aws4.dynamodb,5
```

## parentStyle

`parentStyle` も利用できる。詳細は不明。

https://www.drawio.com/blog/insert-from-csv

```Text
# parentstyle: swimlane;whiteSpace=wrap;html=1;childLayout=stackLayout;horizontal=1;horizontalStack=0;resizeParent=1;resizeLast=0;collapsible=1;
```
