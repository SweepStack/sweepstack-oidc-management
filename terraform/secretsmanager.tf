resource "aws_secretsmanager_secret" "TF_API_KEY" {
  name = "TF_API_KEY"
}

resource "aws_secretsmanager_secret_version" "TF_API_KEY" {
  secret_id     = aws_secretsmanager_secret.TF_API_KEY.id
  secret_string = jsonencode("thisisasecret")
}
