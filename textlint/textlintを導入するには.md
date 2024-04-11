# textlintを導入するには

https://github.com/textlint/textlint

```bash
npm install textlint \
  --save-dev  # 開発環境のみ
```

`.textlintrc.json` を作成する。

```bash
npx textlint --init
# .textlintrc.json is created.
```

```json:.textlintrc.json
{
  "plugins": {},
  "filters": {},
  "rules": {}
}
```

先にルールをインストールすると、ルールに応じた`.textlintrc.json` が作成される。

`textlint-rule-preset-ja-spacing`の例。

```bash
npm install textlint-rule-preset-ja-spacing --save-dev
```

```json:.textlintrc.json
{
  "plugins": {},
  "filters": {},
  "rules": {
    "preset-ja-spacing": true
  }
}
```
