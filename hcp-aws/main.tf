terraform {
  cloud {
    organization = "sweepstack-alpha"
    workspaces {
      name = "sweepstack-oidc-management-hcp-aws"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0.0"
    }
  }
}

