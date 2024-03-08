---
bibliography: 
repositoryUrl:
draft: false
---

# userdataでdotnet8をセットアップするには

https://aws.amazon.com/jp/blogs/dotnet/net-8-support-on-aws/

```bash
#!/bin/bash
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo wget -O /etc/yum.repos.d/microsoft-prod.repo https://packages.microsoft.com/config/fedora/37/prod.repo
sudo dnf install -y dotnet-sdk-8.0
dotnet --version > /tmp/dotnet-version
```
