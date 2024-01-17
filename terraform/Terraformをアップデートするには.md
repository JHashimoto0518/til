---
bibliography: 
repositoryUrl:
draft: false
---

# Terraformをアップデートするには

tfenv がインストールされている前提。

インストールできるバージョンを確認する。

```bash
tfenv list-remote | head
# 1.7.0
# 1.7.0-rc2
# 1.7.0-rc1
# ...
```

インストールする。

```bash
tfenv install 1.7.0
# Installing Terraform v1.7.0
# ...
# Installation of terraform v1.7.0 successful. To make this your default version, run 'tfenv use 1.7.0'
```

利用するバージョンを切り替える。

```bash
tfenv use 1.7.0
# Switching default version to v1.7.0
# Default version (when not overridden by .terraform-version or TFENV_TERRAFORM_VERSION) is now: 1.7.0
```

```bash
terraform --version
# Terraform v1.7.0
# on linux_amd64
```
