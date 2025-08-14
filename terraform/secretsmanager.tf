resource "aws_secretsmanager_secret" "terraformApiKey" {
  name = "TF_API_KEY"
}

resource "aws_secretsmanager_secret_version" "terraformApiKeyVersion" {
  secret_id     = aws_secretsmanager_secret.terraformApiKey.id
  secret_string = jsonencode("thisisasecret")
}

data "aws_secretsmanager_secret" "terraformApiKey" {
  arn = aws_secretsmanager_secret.terraformApiKey.arn
}

data "aws_secretsmanager_secret_version" "terraformApiKeyVersion" {
  secret_id = aws_secretsmanager_secret.terraformApiKey.id
}

output "secretData" {
  value = data.aws_secretsmanager_secret_version.terraformApiKeyVersion.secret_string
}
