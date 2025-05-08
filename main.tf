terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "vpn_tunnel_state" {
  count               = var.enable_vpn_tunnel_state_alarm ? 1 : 0
  alarm_name          = "${var.alarm_name_prefix}-vpn-tunnel-state"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TunnelState"
  namespace           = "AWS/VPN"
  period              = 300
  statistic           = "Minimum"
  threshold           = 1.0
  alarm_description   = "This alarm monitors if any VPN tunnel is in DOWN state"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  dimensions = {
    VpnId = var.vpn_id
  }
  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "individual_tunnel_state" {
  for_each            = var.enable_individual_tunnel_state_alarm ? { for idx, ip in var.tunnel_ip_addresses : idx => ip } : {}
  alarm_name          = "${var.alarm_name_prefix}-tunnel-state-${each.key}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 3
  metric_name         = "TunnelState"
  namespace           = "AWS/VPN"
  period              = 300
  statistic           = "Minimum"
  threshold           = 1.0
  alarm_description   = "This alarm monitors if this specific VPN tunnel is in DOWN state"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.ok_actions
  dimensions = {
    TunnelIpAddress = each.value
  }
  tags = var.tags
} 