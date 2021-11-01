//setup of providers
terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = "1.140.0"
    }
  }
}

//1) setup of alicloud RAM account with resource permisions and obtain the access_key and access_key_secret 
provider "alicloud" {
  access_key = var.my_access_key
  secret_key = var.my_secret_key
  region     = var.my_region
}


data "alicloud_zones" "abc_zones" {}

//3) setup of VPC
resource "alicloud_vpc" "test_vpc" {
  vpc_name   = var.my_vpc
  cidr_block = var.my_vpc_cidr_block
}

//4) setup of vswitch within the VPC
resource "alicloud_vswitch" "test_vswitch" {
  vswitch_name = var.my_vswitch
  vpc_id       = alicloud_vpc.test_vpc.id
  cidr_block   = var.my_vswitch_cidr_block
  zone_id      = data.alicloud_zones.abc_zones.zones.0.id
}
resource "alicloud_vswitch" "test_vswitch_bak" {
  vswitch_name = var.my_vswitch_bak
  vpc_id       = alicloud_vpc.test_vpc.id
  cidr_block   = var.my_vswitch_cidr_block_bak
  zone_id      = data.alicloud_zones.abc_zones.zones.2.id
}

resource "alicloud_cs_serverless_kubernetes" "serverless" {
  name                           = var.my_ask_name
  version                        = "v1.20.4-aliyun.1"
  vpc_id                         = alicloud_vpc.test_vpc.id
  vswitch_ids                    = [alicloud_vswitch.test_vswitch.id,alicloud_vswitch.test_vswitch_bak.id]
  new_nat_gateway                = true
  endpoint_public_access_enabled = true
  deletion_protection            = false
  load_balancer_spec             = "slb.s2.small"
  time_zone                      = "Asia/Shanghai" 
  service_cidr                   = "172.21.0.0/20"
  service_discovery_types        = ["PrivateZone"]


}