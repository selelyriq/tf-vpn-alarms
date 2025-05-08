# AWS VPN CloudWatch Alarms Terraform Module

This Terraform module creates CloudWatch alarms for AWS VPN connections based on AWS best practices. It monitors the state of VPN tunnels and can alert you when tunnels go down.

## Features

- VPN-level tunnel state monitoring
- Individual tunnel state monitoring
- Configurable alarm actions
- Support for tags

## Usage

```hcl
module "vpn_alarms" {
  source = "path/to/module"

  alarm_name_prefix = "my-vpn"
  vpn_id           = "vpn-1234567890abcdef0"
  
  # Optional: List of tunnel IP addresses to monitor individually
  tunnel_ip_addresses = [
    "203.0.113.1",
    "203.0.113.2"
  ]

  # Optional: SNS topic ARNs for notifications
  alarm_actions = ["arn:aws:sns:region:account-id:my-topic"]
  ok_actions    = ["arn:aws:sns:region:account-id:my-topic"]

  # Optional: Tags
  tags = {
    Environment = "production"
    Service     = "vpn"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm_name_prefix | Prefix to be used for the alarm names | `string` | n/a | yes |
| vpn_id | The ID of the VPN connection to monitor | `string` | n/a | yes |
| tunnel_ip_addresses | List of tunnel IP addresses to monitor individually | `list(string)` | `[]` | no |
| enable_vpn_tunnel_state_alarm | Enable/disable the VPN-level tunnel state alarm | `bool` | `true` | no |
| enable_individual_tunnel_state_alarm | Enable/disable individual tunnel state alarms | `bool` | `true` | no |
| alarm_actions | List of ARNs to be notified when the alarm goes into ALARM state | `list(string)` | `[]` | no |
| ok_actions | List of ARNs to be notified when the alarm goes into OK state | `list(string)` | `[]` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn_tunnel_state_alarm_arn | The ARN of the VPN-level tunnel state CloudWatch alarm |
| individual_tunnel_state_alarm_arns | Map of tunnel IP addresses to their corresponding CloudWatch alarm ARNs |

## Alarm Details

### VPN-level Tunnel State Alarm
- Metric: `TunnelState`
- Statistic: Minimum
- Period: 300 seconds
- Evaluation Periods: 3
- Threshold: 1.0
- Comparison Operator: LessThanThreshold

### Individual Tunnel State Alarm
- Metric: `TunnelState`
- Statistic: Minimum
- Period: 300 seconds
- Evaluation Periods: 3
- Threshold: 1.0
- Comparison Operator: LessThanThreshold

## Notes

- The alarms follow AWS best practices for VPN monitoring
- A value less than 1 indicates that the tunnel is in DOWN state
- The alarms will trigger if the tunnel state remains down for 15 minutes (3 evaluation periods of 5 minutes each) # tf-vpn-alarms
