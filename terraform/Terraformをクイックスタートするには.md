---
bibliography: 
    - https://...
repositoryUrl:
    - https://github.com/...
draft: true
---

# Terraformをクイックスタートするには

インストールは済んでいる前提。

```bash
mkdir sandbox
cd sandbox
```

main.tf を記述する。

```tf
terraform {
  # required_version = "1.3.1"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "4.52.0"
    }
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["ap-northeast-1"]
}

output "availability_zone_names" {
  value       = var.availability_zone_names
  description = "value of availability_zone_names"
}
```

AWS の Credential を設定する。今回は環境変数を利用する。

```bash
export AWS_PROFILE="<replace your profile>"
```

プロジェクトを初期化する。

```bash
terraform init

Initializing the backend...

Successfully configured the backend "local"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.32.1...
- Installed hashicorp/aws v5.32.1 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

plan を確認する。

```bash
terraform plan

Changes to Outputs:
  + availability_zone_names = [
      + "ap-northeast-1",
    ]

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

apply する。

```bash
terraform apply

Changes to Outputs:
  + availability_zone_names = [
      + "ap-northeast-1",
    ]

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

availability_zone_names = tolist([
  "ap-northeast-1",
])
```
