---
bibliography: 
repositoryUrl:
draft: false
---

# GetPipelineレスポンスのパイプライン構造は実行順か

ステージの Source と Build をあえて逆に宣言してみる。

updated-pipeline.json

```json
{
    "pipeline": {
        "name": "MyTestPipeline",
        "roleArn": "arn:aws:iam::533267060632:role/role-for-codepipeline-creation-test",
        "artifactStore": {
            "type": "S3",
            "location": "codepipelinestack-pipelineartifactsbucketaea9a052-g3dv9waxgcff"
        },
        "stages": [
            {
                "name": "Build",
                "actions": [
                    {
                        "name": "BuildAction",
                        "actionTypeId": {
                            "category": "Build",
                            "owner": "AWS",
                            "provider": "CodeBuild",
                            "version": "1"
                        },
                        "runOrder": 1,
                        "configuration": {
                            "ProjectName": "MyBuildProject"
                        },
                        "outputArtifacts": [
                            {
                                "name": "BuildOutput"
                            }
                        ],
                        "inputArtifacts": [
                            {
                                "name": "SourceOutput"
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Source",
                "actions": [
                    {
                        "name": "SourceAction",
                        "actionTypeId": {
                            "category": "Source",
                            "owner": "AWS",
                            "provider": "CodeCommit",
                            "version": "1"
                        },
                        "runOrder": 1,
                        "configuration": {
                            "BranchName": "main",
                            "RepositoryName": "MySampleRepository"
                        },
                        "outputArtifacts": [
                            {
                                "name": "SourceOutput"
                            }
                        ],
                        "inputArtifacts": []
                    }
                ]
            }
        ],
        "version": 1
    }
}
```

すると、Source アクションで開始すべきというエラーが出るので、ステージの宣言順は実行順序を表すと考えられる。

```bash
aws codepipeline update-pipeline --cli-input-json file://updated-pipeline.json
# An error occurred (InvalidStructureException) when calling the UpdatePipeline operation: Pipeline should start with a stage that only contains source actions
```

また、GetPipeline のレスポンスは UpdatePipeline のリクエストに利用できる。

https://docs.aws.amazon.com/ja_jp/codepipeline/latest/APIReference/API_GetPipeline.html

https://docs.aws.amazon.com/ja_jp/codepipeline/latest/APIReference/API_UpdatePipeline.html

以上のことから、GetPipeline レスポンスのパイプライン構造は実行順序を表すと考えられる。
