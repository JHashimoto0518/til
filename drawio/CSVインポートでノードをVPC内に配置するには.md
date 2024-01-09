---
bibliography: 
repositoryUrl:
draft: false
---

# CSVインポートでノードをVPC内に配置するには

EC2 などのノードを VPC 内に配置したい。

https://github.com/jgraph/drawio/issues/3731

> Try "container=1" in the shape style.

`container=1` を宣言しただけでは、ノードを VPC 内に配置できなかった。位置指定の方法は不明。

```Text
## Simple web server AWS diagram
# label: %component%
# stylename: shapeType
# styles: {"node": "shape=%shape%;fillColor=%fill%;strokeColor=%stroke%;verticalLabelPosition=bottom;", \
#          "ctr":"points=[[0,0],[0.25,0],[0.5,0],[0.75,0],[1,0],[1,0.25],[1,0.5],[1,0.75],[1,1],[0.75,1],[0.5,1],[0.25,1],[0,1],[0,0.75],[0,0.5],[0,0.25]];outlineConnect=0;gradientColor=none;html=1;whiteSpace=wrap;fontSize=12;fontStyle=0;container=1;pointerEvents=0;collapsible=0;recursiveResize=0;shape=mxgraph.aws4.group;grIcon=mxgraph.aws4.group_vpc2;strokeColor=#8C4FFF;fillColor=none;verticalAlign=top;align=left;spacingLeft=30;fontColor=#AAB7B8;dashed=0;"}
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
id,component,fill,stroke,shape,refs,shapeType
1,ALB,#8C4FFF,#ffffff,mxgraph.aws4.application_load_balancer,,node
2,EC2,#ED7100,#ffffff,mxgraph.aws4.ec2,1,node
3,VPC,#ED7100,#ffffff,mxgraph.aws4.group,,ctr
```
