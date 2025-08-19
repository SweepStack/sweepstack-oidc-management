# Assume role policy for the OIDC provider to allow HCP Terraform to assume roles in AWS.
data "aws_iam_policy_document" "oidc_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.hcp_terraform.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = [local.provider_audience]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values   = ["organization:${local.org_name}:project:${local.project_name}:workspace:*:run_phase:*"]
    }
  }
}

# Create an IAM role for the OIDC provider to assume roles in AWS.
resource "aws_iam_role" "oidc_terraform_connector_iam" {
  name               = "oidc-terraform-connector-iam"
  description        = "Role for HCP Terraform OIDC connector to create and manage IAM users and roles in AWS"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
}

resource "aws_iam_policy" "oidc_iam_permissions_policy" {
  name        = "oidc-iam-permissions"
  description = "Permissions for HCP Terraform OIDC connector to create and manage IAM users and roles in AWS"
  policy      = data.aws_iam_policy_document.oidc_iam_permissions_policy_document.json
}

data "aws_iam_policy_document" "oidc_iam_permissions_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "iam:*",
      "organizations: Describe*",
      "organizations: List*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "oidc_iam_permissions_policy_attachment" {
  role       = aws_iam_role.oidc_terraform_connector_iam.name
  policy_arn = aws_iam_policy.oidc_iam_permissions_policy.arn
}

# Create the OIDC provider for HCP Terraform in AWS IAM.
resource "aws_iam_role" "oidc_terraform_connector_full_perm" {
  name               = "oidc-terraform-connector-full-perm"
  description        = "Role for HCP Terraform OIDC connector to create and manage any AWS resource (look to trim this down later)"
  assume_role_policy = data.aws_iam_policy_document.oidc_assume_role_policy.json
}

resource "aws_iam_policy" "oidc_iam_permissions_policy" {
  name        = "oidc-full-permissions"
  description = "Permissions HCP Terraform OIDC connector to create and manage any AWS resource (look to trim this down later)"
  policy      = data.aws_iam_policy_document.oidc_full_permissions_policy.json
}

data "aws_iam_policy_document" "oidc_full_permissions_policy" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}
