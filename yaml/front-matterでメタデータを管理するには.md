---
bibliography: 
    - https://gohugo.io/content-management/front-matter/
    - https://qiita.com/amay077/items/e27f9b4e2374b70a5dfb
    - https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter#effectivedate
    - https://github.com/jxson/front-matter
    - https://github.com/DavidAnson/markdownlint/blob/v0.32.1/doc/md025.md
repositoryUrl:
draft: true
---

# front-matterでメタデータを管理するには

```yaml
---
bibliography: 
    - https://...
repositoryUrl:
    - https://github.com/...
draft: false
---
```

よく使われる項目。

https://jmatsuzaki.com/archives/27361

    - title: ノートのタイトル（Markdown標準の項目）
    - author: ノートの著者（Markdown標準の項目）
    - date: 作成日（Markdown標準の項目）
    - keywords: ノートのキーワード（Markdown標準の項目）
    - aliases: ノートの別名（Obsidian独自）
    - tags: ノートにつけるタグ（Obsidian独自）

Multi Markdown のガイドライン。

https://github.com/fletcher/MultiMarkdown/wiki/MultiMarkdown-Syntax-Guide

Permanent Note, Structure Note の例。

https://jmatsuzaki.com/archives/28172

```yaml
---
uid: 20220214090000
title: <Noteのタイトル>
aliases: []
date: 2022-01-14 09:00:00
update: 2022-01-15 09:00:00
tags: []
draft: false
---
```
