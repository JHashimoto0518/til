---
bibliography: 
  - https://dev.classmethod.jp/articles/cf-estimate-template-cost/
  - https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/estimate-template-cost.html
repositoryUrl:
draft: true
---

# CloudFormationテンプレートから利用料を見積もるには

テンプレートを用意する。

```bash
export AWS_PROFILE=<your-profile>

npx cdk synth > cfn-tmpl.yaml
```

`AWS::CDK::Metadata` をサポートしていない。

```bash
aws cloudformation estimate-template-cost \
    --template-body file://cfn-tmpl.yaml
# 
# An error occurred (ValidationError) when calling the EstimateTemplateCost operation: Template cost calculations cannot be generated for templates containing resource type AWS::CDK::Metadata.
```

`CDKMetadata` を削除。

```bash
diff cfn-tmpl-ORG.yaml cfn-tmpl.yaml 
# 698,704d697
# <   CDKMetadata:
# <     Type: AWS::CDK::Metadata
# <     Properties:
# <       Analytics: v2:deflate64:H4sIAAAAAAAA/21SwWrDMAz9lt1dbyls7NqVUQqDhbT0OhxHzdQmdrDllBLy71OSpsnGTpbee5aehJYyip7l04O6+IXOzosCU9nsSOmzYOirAb2UzaHSYn00h3gt4pAWqHchNUAdNkWJDQR7lRYw4RO28t5qVITW3MUidlgrgqnG1hA4jjeMXtT11vSWrYhtfZdgSPS6o9LAzt5NVllkcAc6OKTrxtlQ9R7+Alzrrr4VnRf4+2VrcgfeczdPymgYHA5xK1CVsknsMO74jnTs7BELVkGhPKEurMpSVTCFJq95pauq4j32+/hg7q3nwHU1fuVzHXoCc9OM8YzfK5fz6sZhZ2nbigS8Da6bIXiy5ZSy9/8pHqHGrGvhPRCfRM7WO32snCqBBiOfgarQr25tTYadj1YYm4E8+cc6epXRC1/XySMuXDCEJchkeH8Ae97H8XoCAAA=
# <     Metadata:
# <       aws:cdk:path: CdkPrivateYumSampleStack/CDKMetadata/Default
# <     Condition: CDKMetadataAvailable
```

`Custom::...` もサポートしていない模様。

```bash
aws cloudformation estimate-template-cost     --template-body file://cfn-tmpl.yaml
# 
# An error occurred (ValidationError) when calling the EstimateTemplateCost operation: Template cost calculations cannot be generated for templates containing resource type Custom::VpcRestrictDefaultSG.
```

`Custom::VpcRestrictDefaultSG` も削除。

```bash
diff cfn-tmpl-ORG.yaml cfn-tmpl.yaml 
# 211,227d210
# <   WebVpcRestrictDefaultSecurityGroupCustomResource9134D140:
# <     Type: Custom::VpcRestrictDefaultSG
# <     Properties:
# <       ServiceToken:
# <         Fn::GetAtt:
# <           - CustomVpcRestrictDefaultSGCustomResourceProviderHandlerDC833E5E
# <           - Arn
# <       DefaultSecurityGroupId:
# <         Fn::GetAtt:
# <           - WebVpc46147648
# <           - DefaultSecurityGroup
# <       Account:
# <         Ref: AWS::AccountId
# <     UpdateReplacePolicy: Delete
# <     DeletionPolicy: Delete
# <     Metadata:
# <       aws:cdk:path: CdkPrivateYumSampleStack/WebVpc/RestrictDefaultSecurityGroupCustomResource/Default
# 698,704d680
# <   CDKMetadata:
# <     Type: AWS::CDK::Metadata
# <     Properties:
# <       Analytics: v2:deflate64:H4sIAAAAAAAA/21SwWrDMAz9lt1dbyls7NqVUQqDhbT0OhxHzdQmdrDllBLy71OSpsnGTpbee5aehJYyip7l04O6+IXOzosCU9nsSOmzYOirAb2UzaHSYn00h3gt4pAWqHchNUAdNkWJDQR7lRYw4RO28t5qVITW3MUidlgrgqnG1hA4jjeMXtT11vSWrYhtfZdgSPS6o9LAzt5NVllkcAc6OKTrxtlQ9R7+Alzrrr4VnRf4+2VrcgfeczdPymgYHA5xK1CVsknsMO74jnTs7BELVkGhPKEurMpSVTCFJq95pauq4j32+/hg7q3nwHU1fuVzHXoCc9OM8YzfK5fz6sZhZ2nbigS8Da6bIXiy5ZSy9/8pHqHGrGvhPRCfRM7WO32snCqBBiOfgarQr25tTYadj1YYm4E8+cc6epXRC1/XySMuXDCEJchkeH8Ae97H8XoCAAA=
# <     Metadata:
# <       aws:cdk:path: CdkPrivateYumSampleStack/CDKMetadata/Default
# <     Condition: CDKMetadataAvailable
```

AWS Pricing Calculator の URL が発行された。

```bash
aws cloudformation estimate-template-cost --template-body file://cfn-tmpl.yaml
# {
#     "Url": "https://calculator.aws/#/estimate?id=cloudformation/5ef947ad53045d2f392460ed4f45b037d3080e78"
# }
```

なぜか、Estimate は 0 だった。

![alt text](image.png)
