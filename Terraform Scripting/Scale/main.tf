terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
#terraform_remote_state 
data "terraform_remote_state" "infra" {
  backend = "local"

  config = {
    path = "../Compute/terraform.tfstate"
  }
}