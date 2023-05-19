# Account setup
variable "profile" {
  description           = "The profile from ~/.aws/credentials file used for authentication. By default it is the default profile."
  type                  = string
  default               = "default"
}

variable "accountID" {
  description           = "ID of your AWS account. It is a required variable normally used in JSON files or while assuming a role."
  type                  = string

  validation {
    condition           = length(var.accountID) == 12
    error_message       = "Please, provide a valid account ID."
  }
}

variable "region" {
  description           = "The region for the resources. By default it is eu-west-1."
  type                  = string
  default               = "eu-west-1"
}

variable "assumeRole" {
  description           = "Enable / Disable role assume. This is disabled by default and normally used for sub organization configuration."
  type                  = bool
  default               = false
}

variable "assumableRole" {
  description           = "The role the user will assume if assumeRole is enabled. By default, it is OrganizationAccountAccessRole."
  type                  = string
  default               = "OrganizationAccountAccessRole"
}

variable "name" {
  description = "Application name. Required value."
  type        = string
}
variable "domain" {
  description = "Root domain of the application. Required value."
  type        = string
}
variable "cw_log_enabled" {
  description = "Logs are kept for 30 days in RUM, if you want to keep them for longer, enable CW logging. Defaults to false."
  type        = bool
  default     = false
}
variable "custom_events_enabled" {
  description = "By default RUM logs only what is in the telemetries configuration. In case you want to log custom events, enable this variable. Defaults to false."
  type        = bool
  default     = false
}
variable "telemetries" {
  description = "List of the types of telemetry data. By default we collect all types. However you can limit down the list here. Example: [\"errors\", \"performance\"]. Defaults to [\"errors\", \"performance\", \"http\"]"
  type        = list(string)
  default     = ["errors", "performance", "http"]
}
variable "cookies_enabled" {
  description = "If enabled, events will be aggregated based on user or a session. Defaults to true."
  type        = bool
  default     = true
}
variable "xray_enabled" {
  description = "If enabled, X Ray will be used to debug the end to end request through all of the AWS services. Defaults to false."
  type        = bool
  default     = false
}
variable "excluded_pages" {
  description = "List of pages to exclude from monitoring. By default, the list is empty."
  type        = list(string)
  default     = []
}
variable "included_pages" {
  description = "List of pages to monitor. If empty, all pages are monitored. By default empty list."
  type        = list(string)
  default     = []
}
variable "favourite_pages" {
  description = "List of pages that will be flagged as favourite in the RUM. By default empty list."
  type        = list(string)
  default     = []
}
variable "sample_rate" {
  description = "Percent of sessions you would like to collect and analyze. 1 is 100%, 0.1 is 10%. By default it is set to 100%."
  type        = number
  default     = 1
}