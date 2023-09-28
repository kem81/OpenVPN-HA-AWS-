terraform {
  required_providers {
     aws = {
     source = "hashicorp/aws"
     version = "5.12.0"
     }
  }
  backend "http" {
  }
}
provider "aws" {
  assume_role {
    role_arn = var.deployment_role
    }
   region = var.default_region 
}

# provider "aws" {
#    region = var.default_region # Change to your desired AWS region
#   assume_role {
#     role_arn    = var.deployment_role
#   }
# }