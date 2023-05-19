# mod-terraform-aws-cw-rum

Terraform module to create Cloudwatch Real User monitoring App

## Variables

- **profile** - The profile from ~/.aws/credentials file used for authentication. By default it is the default profile.
- **accountID** - ID of your AWS account. It is a required variable normally used in JSON files or while assuming a role.
- **region** - The region for the resources. By default it is eu-west-1.
- **assumeRole** - Enable / Disable role assume. This is disabled by default and normally used for sub organization configuration.
- **assumableRole** - The role the user will assume if assumeRole is enabled. By default, it is OrganizationAccountAccessRole.
- **name** - Application name. Required value.
- **domain** - Root domain of the application. Required value.
- **cw_log_enabled** - Logs are kept for 30 days in RUM, if you want to keep them for longer, enable CW logging. Defaults to false.
- **custom_events_enabled** - By default RUM logs only what is in the telemetries configuration. In case you want to log custom events, enable this variable. Defaults to false.
- **telemetries** - List of the types of telemetry data. By default we collect all types. However you can limit down the list here. Example: ["errors", "performance"]. Defaults to ["errors", "performance", "http"]
- **cookies_enabled** - If enabled, events will be aggregated based on user or a session. Defaults to true.
- **xray_enabled** - If enabled, X Ray will be used to debug the end to end request through all of the AWS services. Defaults to false.
- **excluded_pages** - List of pages to exclude from monitoring. By default, the list is empty.
- **included_pages** - List of pages to monitor. If empty, all pages are monitored. By default empty list.
- **favourite_pages** - List of pages that will be flagged as favourite in the RUM. By default empty list.
- **sample_rate** - Percent of sessions you would like to collect and analyze. 1 is 100%, 0.1 is 10%. By default it is set to 100%.

## Example


``` terraform
variable accountID { default = "123456789012"}

module "cw_rum_example_admin_app" {
  source   = "git::https://github.com/virsas/mod-terraform-aws-cw-rum.git?ref=v1.0.0"

  profile = "default"
  accountID = var.accountID
  region = "eu-west-1"

  name            = "admin_app"
  domain          = "example.com"
}
```

## Outputs

- id
- arn
- app_monitor_id
- cw_log_group