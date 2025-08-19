resource "tfe_variable" "tfc_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = terraform.workspace.id
}

resource "tfe_variable" "tfc_example_role_arn" {
  sensitive    = true
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = aws_iam_role.oidc_terraform_connector_iam.arn
  category     = "env"
  workspace_id = terraform.workspace.id
}
