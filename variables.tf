variable "my_count_min" {
  default = "2"
}

variable "my_count_max" {
  default = "2"
}

variable "my_count_format" {
  default = "%02d"
}

variable "my_access_key" {
  description = "RAM user access_key"
  sensitive   = true
}

variable "my_secret_key" {
  description = "RAM user secret_key"
  sensitive   = true
}

variable "my_region" {
  default = "cn-hongkong"
}

variable "my_vpc" {
  default = "test_vpc"
}

variable "my_vpc_cidr_block" {
  default = "10.1.0.0/21"
}

variable "my_vswitch" {
  default = "test_vswitch"
}
variable "my_vswitch_bak" {
  default = "test_vswitch_bak"
}

variable "my_vswitch_cidr_block" {
  default = "10.1.0.0/24"
}
variable "my_vswitch_cidr_block_bak" {
  default = "10.1.1.0/24"
}

variable "my_ask_name" {
  default = "ask001"
}

