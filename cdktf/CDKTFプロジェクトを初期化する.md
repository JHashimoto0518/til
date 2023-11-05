# CDKTFプロジェクトを初期化する

```bash
export WORK_DIR=cdktf-test
mkdir $WORK_DIR
cd $WORK_DIR
cdktf init \
  --template="typescript" \
  --providers="aws@~>5.0" \
  --local   # ステートをローカルで管理する
```
