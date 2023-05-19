output "id" {
  value = try(aws_rum_app_monitor.vss.id, "")
}
output "arn" {
  value = try(aws_rum_app_monitor.vss.arn, "")
}
output "app_monitor_id" {
  value = try(aws_rum_app_monitor.vss.app_monitor_id, "")
}
output "cw_log_group" {
  value = try(aws_rum_app_monitor.vss.cw_log_group, "")
}