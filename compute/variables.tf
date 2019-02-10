variable "region" {
  description = "Where you want to create the server. Regions: par1 and ams1"
  default     = "par1"
}

variable "number_of_servers" {
  description = "How many servers you want to create"
  default     = 1
}

variable "name" {
  description = "Give a name for the server"
  default     = ""
}

variable "server_type" {
  description = "Server type"
  default     = "VC1S"
}

variable "tags" {
  type        = "list"
  description = "Give tags for server(s)"
  default     = []
}

variable "additional_volumes" {
  type        = "map"
  description = "Create additional volumes"
  default     = {}
}

variable "image_architecture" {
  description = "The image architecture you want to use to create the server. Should be arm or x86_64"
  default     = "x86_64"
}

variable "image_name" {
  description = "Image name or name of os you want to use for the server"
  default     = "Ubuntu Xenial"
}

variable "security_group_name" {
  description = "Give a name for security group"
  default     = ""
}

variable "security_group_desc" {
  description = "Description for security group"
  default     = "Managed by Terraform"
}

variable "enable_ip" {
  description = "Provides IPs for servers"
  default     = true
}

variable "default_security" {
  description = "Should be true if you want security group as default one"
  default     = true
}

variable "create_default_security_group" {
  description = "Should be true if you want to apply default security group"
  default     = true
}

variable "additional_security_rules" {
  type        = "map"
  description = "Add additional rules to the security group"
  default     = {}
}

variable "enable_ipv6" {
  description = "Enable IPv6"
  default     = false
}

variable "server_state" {
  description = "The state of the server. Values are stopped and running"
  default     = "running"
}
