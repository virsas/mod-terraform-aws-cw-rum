provider "aws" {
  profile = var.profile
  region = var.region

  assume_role {
    role_arn = var.assumeRole ? "arn:aws:iam::${var.accountID}:role/${var.assumableRole}" : null
  }
}

resource "aws_cognito_identity_pool" "vss" {
  identity_pool_name               = "RUM-${var.name}"
  allow_unauthenticated_identities = true
}

data "aws_iam_policy_document" "trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.vss.id]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["unauthenticated"]
    }
  }
}

resource "aws_iam_role" "vss" {
  name               = "RUM-Cognito-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_cognito_identity_pool_roles_attachment" "vss" {
  identity_pool_id = aws_cognito_identity_pool.vss.id
  roles = {
    "unauthenticated" = aws_iam_role.vss.arn
  }
}

resource "aws_rum_app_monitor" "vss" {
  name                          = var.name
  domain                        = var.domain

  cw_log_enabled                = var.cw_log_enabled

  custom_events {
    status                      = var.custom_events_enabled ? "ENABLED" : "DISABLED"
  }

  app_monitor_configuration {
    telemetries                 = var.telemetries

    allow_cookies               = var.cookies_enabled
    enable_xray                 = var.xray_enabled

    excluded_pages              = var.excluded_pages
    included_pages              = var.included_pages
    favorite_pages             = var.favorite_pages

    session_sample_rate         = var.sample_rate

    identity_pool_id            = aws_cognito_identity_pool.vss.id
    guest_role_arn              = aws_iam_role.vss.arn
  }
}

data "aws_iam_policy_document" "permission" {
  statement {
    effect = "Allow"
    actions = ["rum:PutRumEvents"]
    resources = [aws_rum_app_monitor.vss.arn]
  }
}

resource "aws_iam_role_policy" "vss" {
  name   = "RUM-Cognito-Role-${var.name}"
  role   = aws_iam_role.vss.id
  policy = data.aws_iam_policy_document.permission.json
}