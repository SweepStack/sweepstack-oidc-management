locals {
  org_name          = "sweepstack-alpha"
  project_name      = "SweepStack"
  region            = "us-east-1"
  environment       = "sbx"
  provider_url      = "https://app.terraform.io"
  provider_audience = "aws.workload.identity" # Default audience in HCP Terraform for AWS.
}
