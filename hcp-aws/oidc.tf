data "tls_certificate" "provider" {
  url = local.provider_url
}

resource "aws_iam_openid_connect_provider" "hcp_terraform" {
  url = local.provider_url

  client_id_list = [
    local.provider_audience,
  ]

  thumbprint_list = [
    data.tls_certificate.provider.certificates[0].sha1_fingerprint,
  ]
}
