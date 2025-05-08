output "vpn_tunnel_state_alarm_arn" {
  description = "The ARN of the VPN-level tunnel state CloudWatch alarm"
  value       = var.enable_vpn_tunnel_state_alarm ? aws_cloudwatch_metric_alarm.vpn_tunnel_state[0].arn : null
}

output "individual_tunnel_state_alarm_arns" {
  description = "Map of tunnel IP addresses to their corresponding CloudWatch alarm ARNs"
  value       = var.enable_individual_tunnel_state_alarm ? { for k, v in aws_cloudwatch_metric_alarm.individual_tunnel_state : k => v.arn } : {}
} 