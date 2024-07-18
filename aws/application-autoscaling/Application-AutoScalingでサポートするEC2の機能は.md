---
bibliography: 
repositoryUrl:
draft: false
---

# Application-AutoScalingでサポートするEC2の機能は

スケーリングポリシーでサポートするEC2はスポットフリートであり、一般的に利用されるAuto Scalingグループではない。

https://docs.aws.amazon.com/autoscaling/application/userguide/services-that-can-integrate-ec2.html

> ターゲット トラッキング スケーリング ポリシー、ステップ スケーリング ポリシー、スケジュールされたスケーリングを使用して、スポット フリートをスケーリングできます。

なお、AWSは現在、スポットフリートの利用を推奨していない。

https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/spot-fleet.html

> コンソールを使用してスポットインスタンスを含むフリートを作成する場合は、スポットフリートではなく Auto Scaling グループを使用することをお勧めします。
>
> AWS CLI を使用してスポットインスタンスを含むフリートを作成する場合は、スポットフリートではなく Auto Scaling グループまたは EC2 フリートのいずれかを使用することをお勧めします。スポットフリートのベースとなる RequestSpotFleet API は、投資が計画されていないレガシー API です。
