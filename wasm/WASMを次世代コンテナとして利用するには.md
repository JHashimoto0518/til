---
bibliography: 
repositoryUrl:
draft: true
---

# WASMを次世代コンテナとして利用するには

コンテナの次としての WASM。

https://zenn.dev/koduki/articles/9f86d03cd703c4

Postgres-WASM は、ブラウザで動作する PostgreSQL 環境。WASM を用いてブラウザに x86 の仮想マシンを構成している。

https://www.publickey1.jp/blog/22/postgresqlwebpostgre-wasmwebx86.html

https://dev.classmethod.jp/articles/play-with-postgres-wasm/

リポジトリ: https://github.com/snaplet/postgres-wasm

同様のアプローチで実現した Postgres playground が公開されているが、OSS ではない。

https://www.publickey1.jp/blog/22/webassemblypostgresqlwebpostgres_playgroundcrunchy_data.html

なお、WebContainer は、ブラウザ上で実現される Node.js 実行環境であり、コンテナ技術とは関係ない。

https://www.publickey1.jp/blog/23/webwebassemblynodejswebcontainerapihttpnodejs_cli.html