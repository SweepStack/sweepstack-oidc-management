variable "TFC_WORKSPACE_NAME" {
  description = "The name of the current Terraform Cloud workspace."
  type        = string
}

data "tfe_workspace" "current_workspace" {
  name         = var.TFC_WORKSPACE_NAME
  organization = local.org_name
}

resource "tfe_variable" "tfc_aws_provider_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = "true"
  category     = "env"
  workspace_id = data.tfe_workspace.current_workspace.id
}

resource "tfe_variable" "tfc_example_role_arn" {
  sensitive    = true
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = aws_iam_role.oidc_terraform_connector_iam.arn
  category     = "env"
  workspace_id = data.tfe_workspace.current_workspace.id
}
