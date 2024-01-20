---
bibliography: 
repositoryUrl:
draft: false
---

# CDKTFでHCLを合成するには

CDKTF の ver.0.20 で HCL の合成がサポートされた。

https://www.hashicorp.com/blog/cdktf-0-20-improves-implementation-of-iterators-and-enables-hcl-output

経緯は、issue で確認できる。

https://github.com/hashicorp/terraform-cdk/issues/225

まず、CDKTF をアップデートする。

```bash
npm i -g cdktf@latest cdktf-cli@latest
cdktf --version
# 0.20.0
```

`--hcl`オプションが追加されている。

https://developer.hashicorp.com/terraform/cdktf/cli-reference/commands#synth

```bash
cdktf synth --help
# cdktf synth
# 
# Synthesizes Terraform code for the given app in a directory.
# 
# Options:
#       ...
#       --hcl                                      Should the output be in HCL format?                                           [boolean] [default: false]
#       ...
```

npm list cdktf でエラー。

```bash
npm list cdktf
npm ERR! code ELSPROBLEMS
npm ERR! invalid: cdktf@0.20.0 /home/jhashimoto/rep/jhashimoto0518/build-ec2-with-cdktf-sample/sample/node_modules/cdktf
sample@1.0.0 /home/jhashimoto/rep/jhashimoto0518/build-ec2-with-cdktf-sample/sample
├─┬ @cdktf/provider-aws@18.0.1
│ └── cdktf@0.20.0 deduped invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
├─┬ cdktf-cli@0.20.0
│ ├─┬ @cdktf/cli-core@0.20.0
│ │ └── cdktf@0.20.0 deduped invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
│ ├─┬ @cdktf/commons@0.20.0
│ │ └── cdktf@0.20.0 deduped invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
│ ├─┬ @cdktf/hcl2cdk@0.20.0
│ │ └── cdktf@0.20.0 deduped invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
│ └── cdktf@0.20.0 deduped invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
└── cdktf@0.20.0 invalid: "^0.19.0" from node_modules/@cdktf/provider-aws
```

ChatGPT に質問した。

> invalid: "^0.19.0" from node_modules/@cdktf/provider-aws: これは、@cdktf/provider-aws パッケージがバージョン ^0.19.0 の cdktf に依存していることを期待しているが、実際には 0.20.0 がインストールされているため、依存関係が不整合であることを示しています。invalid は、インストールされたバージョンが @cdktf/provider-aws の期待するバージョン範囲と一致しないことを意味します。

@cdktf/provider-aws の最新バージョン 0.19 にアップデートする。

```bash
npm i @cdktf/provider-aws@latest
npm list @cdktf/provider-aws
# sample@1.0.0 <parent dir>/sample
```

HCL を合成する。

```bash
cdktf synth --hcl
```

cdktf.out/stacks/aws_instance/cdk.tf:

```hcl
terraform {
  required_providers {
    aws = {
      version = "5.31.0"
      source  = "aws"
    }
  }
  backend "local" {
    path = "<parent dir>/sample/terraform.aws_instance.tfstate"
  }


}

provider "aws" {
  region = "ap-northeast-1"
}
resource "aws_instance" "compute" {
  ami           = "ami-0d48337b7d3c86f62"
  instance_type = "t2.micro"
  tags = {
    Name = "CDKTF-Demo"
  }
}

output "public_ip" {
  value = "${aws_instance.compute.public_ip}"
}
```

もちろん、JSON の合成もできる。

```bash
cdktf synth
```

```json
{
  "//": {
    "metadata": {
      "backend": "local",
      "stackName": "aws_instance",
      "version": "0.20.0"
    },
    "outputs": {
      "aws_instance": {
        "public_ip": "public_ip"
      }
    }
  },
  "output": {
    "public_ip": {
      "value": "${aws_instance.compute.public_ip}"
    }
  },
  "provider": {
    "aws": [
      {
        "region": "ap-northeast-1"
      }
    ]
  },
  "resource": {
    "aws_instance": {
      "compute": {
        "//": {
          "metadata": {
            "path": "aws_instance/compute",
            "uniqueId": "compute"
          }
        },
        "ami": "ami-0d48337b7d3c86f62",
        "instance_type": "t2.micro",
        "tags": {
          "Name": "CDKTF-Demo"
        }
      }
    }
  },
  "terraform": {
    "backend": {
      "local": {
        "path": "<parent dir>/sample/terraform.aws_instance.tfstate"
      }
    },
    "required_providers": {
      "aws": {
        "source": "aws",
        "version": "5.31.0"
      }
    }
  }
}
```
