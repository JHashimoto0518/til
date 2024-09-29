---
bibliography: 
repositoryUrl:
draft: true
---

# MermaidでAWS構成図を書くには

Mermaid でアーキテクチャ図がサポートされた。

https://zenn.dev/iharuoru/articles/630ae2e4d7230d

https://mermaid.js.org/syntax/architecture.html

icones.js.org で提供されているアイコンを使うことができる。icones.js.org では一部の AWS アイコンがサポートされている。

https://zenn.dev/hayato94087/articles/f440b2421dffce

https://coliss.com/articles/build-websites/operation/work/icon-explorer-with-searching-icones.html

## すべてのアイコンを使うには？

Perprexity の回答。

<pre>
具体的な手順は以下の通りです：

## カスタムAWSアイコンパックの作成と使用

1. AWS Architecture Iconsをダウンロード:
   https://aws.amazon.com/architecture/icons/ からSVG形式のアイコンをダウンロードします。

2. アイコンファイルの準備:
   ダウンロードしたSVGファイルを適切なディレクトリに配置します。

3. カスタムアイコンパックの定義:
   以下のようなJavaScriptファイルを作成して、カスタムアイコンパックを定義します。

   ```javascript
   const awsIcons = {
     'ec2': 'path/to/ec2-icon.svg',
     's3': 'path/to/s3-icon.svg',
     // 他のAWSサービスアイコンも同様に追加
   };

   mermaid.registerIconPacks({
     'aws': awsIcons
   });
   ```

4. Mermaidの設定:
   Mermaidを初期化する際に、カスタムアイコンパックを使用するよう設定します。

   ```javascript
   mermaid.initialize({
     // 他の設定
     iconPacks: ['aws'],
   });
   ```

5. アーキテクチャ図でのアイコン使用:
   以下のようにMermaidコードでAWSアイコンを指定します。

   ```
   architecture-beta
   group aws(aws:ec2)[EC2 Instance]
   service s3(aws:s3)[S3 Bucket]
   
   aws --> s3
   ```
</pre>

Mermaid API の使用例を参考に試してみる。

https://qiita.com/hirokiwa/items/7136e5c86fb85814a2a6