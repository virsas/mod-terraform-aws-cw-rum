provider "aws" {
  profile = var.profile
  region = var.region

  assume_role {
    role_arn = var.assumeRole ? "arn:aws:iam::${var.accountID}:role/${var.assumableRole}" : null
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
  }
}