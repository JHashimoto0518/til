---
bibliography: 
repositoryUrl:
draft: false
---

# drawioでインポートするCSVの仕様

書式設定オプションの説明。

https://drawio-app.com/blog/automatically-create-draw-io-diagrams-from-csv-files/

https://www.drawio.com/blog/insert-from-csv

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
