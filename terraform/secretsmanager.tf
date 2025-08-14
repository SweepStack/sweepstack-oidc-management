resource "aws_secretsmanager_secret" "terraformApiKey" {
  name = "TF_API_KEY"
}

resource "aws_secretsmanager_secret_version" "terraformApiKeyVersion" {
  secret_id     = aws_secretsmanager_secret.terraformApiKey.id
  secret_string = "thisisasecret"
}

output "secretData" {
  description = "The secret data for the Terraform API key"
  value       = aws_secretsmanager_secret_version.terraformApiKeyVersion.secret_string
  sensitive   = true
}
