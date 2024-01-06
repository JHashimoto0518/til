---
bibliography: 
    - https://dev.classmethod.jp/articles/aws-cloudshell-support-docker/
    - https://docs.aws.amazon.com/cloudshell/latest/userguide/welcome.html
repositoryUrl:
draft: true
todo:
  - DockerFileを精査する
---

# DockerでNginxを起動するには

Nginx のコンテナを起動する手順。

DockerFile を作成する。

```bash
mkdir nginx
cd nginx/
```

```bash
cat <<EOF > Dockerfile
> FROM public.ecr.aws/amazonlinux/amazonlinux:2
> 
> RUN amazon-linux-extras enable epel && \
>     yum install -y epel-release && \
>     yum install -y nginx
> 
> COPY index.html /usr/share/nginx/html/index.html
> 
> CMD ["nginx", "-g", "daemon off; error_log /dev/stdout info;"]
> EOF
```

コンテンツを作成する。

```bash
cat <<EOF > index.html
> <!DOCTYPE html>
> <html>
> 
> <head>
>     <title>CloudShell supports Docker Yeeeeeeeah!</title>
> </head>
> 
> <body>
>     <h1>CloudShell supports Docker Yeeeeeeeah!</h1>
>     <p>We are very happy that Docker can be used in CloudShell environment!</p>
> </body>
> 
> </html>
> EOF
ls
# Dockerfile  index.html
```

イメージをビルドする。

```bash
docker image build -t nginx-demo .
# [+] Building 38.5s (5/7)                                                                                                                         docker:default
#  => [internal] load build definition from Dockerfile                                                                                                       0.0s
# ...
#  => => naming to docker.io/library/nginx-demo                                                                               0.0s 
```

```bash
docker image ls \
  -a  # 全てのイメージを表示（デフォルトは、中間イメージを非表示）
# REPOSITORY   TAG       IMAGE ID       CREATED              SIZE
# nginx-demo   latest    a1f54f6e3f20   About a minute ago   633MB
```

コンテナを起動する。

https://docs.docker.jp/engine/reference/commandline/container_run.html

```bash
docker container run \
  -d \                  # --detach: バックグラウンドで実行
  -p 8080:80 \          # --publish: コンテナの80ポートをホストの8080ポートで公開
  --rm \                # コンテナ終了時に自動的に削除
  --name nginx-demo \   # コンテナに名前を割り当て
  nginx-demo \          # イメージ
# de7743654e58b5414dc6a87bea4a720de350a885e7fc63707c264481baea68c3
```

```bash
docker container ls \
  -a  # 全てのコンテナを表示（デフォルトは、実行中のコンテナのみ）
# CONTAINER ID   IMAGE        COMMAND                  CREATED          STATUS         PORTS                                   NAMES
# de7743654e58   nginx-demo   "nginx -g 'daemon of…"   36 seconds ago   Up 9 seconds   0.0.0.0:8080->80/tcp, :::8080->80/tcp   nginx-demo
```

テストする。

```bash
curl localhost:8080
# <!DOCTYPE html>
# <html>
# ...
# </html>
```
