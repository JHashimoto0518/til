---
bibliography: 
repositoryUrl:
draft: true
---

# AuroraのDBクラスターパラメータとDBインスタンスパラメータ

https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/AuroraUserGuide/USER_WorkingWithDBClusterParamGroups.html#Aurora.Managing.ParameterGroups

- 変更した DB パラメータ設定は、構成設定を変更してデフォルト値に戻した場合でも、DB クラスターパラメータグループ値より優先される
- オーバーライドされるパラメーターは、Source フィールドで判別できる。該当するパラメータを変更した場合、値が user になる

Q. instanceに複数パラメータグループを設定できるか？
A. instanceには、複数パラメータグループを設定できない

Q. クラスターとインスタンスに異なるパラメータグループが設定されている場合に、instanceのDBParameterGroupsには、クラスターのParameterGroupも返却されるか？
A. 返却されない

Q. APIレスポンスで、複数のパラメータグループが返却されることはあるか？
A. ないと思われる
