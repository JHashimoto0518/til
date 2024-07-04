#!/bin/bash

# パイプライン名を設定
PIPELINE_NAME="MyTestPipeline"

# 1. create-pipeline でパイプラインを作成
echo "1. Creating pipeline..."
aws codepipeline create-pipeline --cli-input-json file://create-pipeline.json

# 2. get-pipeline でパイプラインの構造を取得
echo "2. Getting pipeline structure..."
aws codepipeline get-pipeline --name $PIPELINE_NAME > original-pipeline.json

# 3. update-pipeline で更新したパイプライン構造を適用
aws codepipeline update-pipeline --cli-input-json file://updated-pipeline.json

# 4. 更新後のパイプライン構造を取得
echo "4. Getting updated pipeline structure..."
aws codepipeline get-pipeline --name $PIPELINE_NAME > final-pipeline.json

echo "Pipeline update complete. Check 'final-pipeline.json' for the updated structure."