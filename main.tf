terraform {
  cloud {
    organization = "sweepstack-alpha"
    workspaces {
      name = "sweepstack-oidc-management"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0.0"
    }
  }
}

