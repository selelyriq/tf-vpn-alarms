variable "alarm_name_prefix" {
  description = "Prefix to be used for the alarm names"
  type        = string
}

variable "vpn_id" {
  description = "The ID of the VPN connection to monitor"
  type        = string
}

variable "tunnel_ip_addresses" {
  description = "List of tunnel IP addresses to monitor individually"
  type        = list(string)
  default     = []
}

variable "enable_vpn_tunnel_state_alarm" {
  description = "Enable/disable the VPN-level tunnel state alarm"
  type        = bool
  default     = true
}

variable "enable_individual_tunnel_state_alarm" {
  description = "Enable/disable individual tunnel state alarms"
  type        = bool
  default     = true
}

variable "alarm_actions" {
  description = "List of ARNs to be notified when the alarm goes into ALARM state"
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "List of ARNs to be notified when the alarm goes into OK state"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
} 