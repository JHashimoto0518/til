---
bibliography: 
    - https://developer.hashicorp.com/terraform/language/values/variables
repositoryUrl:
    - https://github.com/JHashimoto0518/terraform-exercise/tree/main/variable
draft: false
---

# list型のvariableを宣言するには

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

コマンドラインで、variable を指定する。指定しない場合は、デフォルト値が適用される。

```bash
terraform apply -var='availability_zone_names=["ap-northeast-1","us-east-1"]'
# ...
# Outputs:
# 
# availability_zone_names = tolist([
#   "ap-northeast-1",
#   "us-east-1",
# ])
```
