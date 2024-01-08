---
bibliography: 
repositoryUrl:
draft: false
---

# CSVでサポートするAWSアイコンは

DynamoDB であれば、`mxgraph.aws3.dynamodb`, `mxgraph.aws4.dynamodb` のいずれかをサポートしている模様。

図形名を確認するには、図形を選択し、コンテキストメニューから `フォーマットを編集...` を選択すればよい。

例えば、AWS18 EC2 のフォーマットを確認すると、`mxgraph.aws4.ec2` のアイコンを使用していることがわかる。

```Text
sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;strokeColor=#ffffff;fillColor=#232F3E;dashed=0;verticalLabelPosition=middle;verticalAlign=bottom;align=center;html=1;whiteSpace=wrap;fontSize=10;fontStyle=1;spacing=3;shape=mxgraph.aws4.productIcon;prIcon=mxgraph.aws4.ec2;
```

同様に、ALB は、`mxgraph.aws4.application_load_balancer` を使用している。

```Text
sketch=0;outlineConnect=0;fontColor=#232F3E;gradientColor=none;fillColor=#8C4FFF;strokeColor=none;dashed=0;verticalLabelPosition=bottom;verticalAlign=top;align=center;html=1;fontSize=12;fontStyle=0;aspect=fixed;pointerEvents=1;shape=mxgraph.aws4.application_load_balancer;
```

なお、URL 指定もできる模様。

https://drawio-app.com/wp-content/uploads/2018/03/drawio-example-csv-import.txt

```Text
...
## ---- CSV below this line. First line are column names. ----
name,position,id,location,manager,email,fill,stroke,refs,url,image
Evan Miller,CFO,emi,Office 1,,me@example.com,#dae8fc,#6c8ebf,,https://www.draw.io,https://cdn3.iconfinder.com/data/icons/user-avatars-1/512/users-9-2-128.png
...
```

その他、確認したリソース。

公式をフォークしたリポジトリ。大量の AWS アイコン指定がある。

https://github.com/attie/draw.io/blob/master/src/main/java/com/mxgraph/io/gliffy/importer/gliffyTranslation.properties

AWS18 アイコンはリリースされているが、CSV で `mxgraph.aws18.dynamodb` をインポートしても、背景色のみが描画される。`mxgraph.aws17.dynamodb` でも同様。

https://drawio-app.com/blog/new-aws-icons-2018/
