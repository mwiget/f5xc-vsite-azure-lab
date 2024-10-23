variable "ssh_public_key" {}
variable "f5xc_vsite_name" {}

variable "f5xc_api_url" {}
variable "f5xc_api_token" {}
variable "f5xc_tenant" {}
variable "f5xc_tunnel_type" {}

# azure

variable "vnet_cidr_block" {}
variable "azure_owner_tag" {}
variable "azure_slo_subnets" {
  type = list(string)
  default = []
}
variable "azure_sli_subnets" {
  type = list(string)
  default = []
}
variable "azure_sli_workload_ip" {
  type = list(string)
  default = []
}
variable "azure_availability_zones" {
  type = list(string)
  default = []
}
variable "azure_storage_account" {}
variable "azure_storage_account_rg" {}
variable "azure_image_name" {}
variable "resource_group_name" {}
variable "resource_group_location" {}
variable "azure_sku_flavor" {}
variable "azure_disk_size" {}
variable "azure_subscription_id" {}

variable "f5xc_ce_slo_probe_port" {
  type    = number
  default = 9505
}

variable "f5xc_ce_sli_probe_port" {
  type    = number
  default = 65450
}
