variable "project_prefix" {
  type        = string
  default     = "f5xc"
}

variable "ssh_public_key" {
  type        = string
  default     = ""
}

# F5XC 

variable "f5xc_api_url"        {}
variable "f5xc_api_token"      {}
variable "f5xc_tenant"         {}
variable "f5xc_tunnel_type" {
  type    = string
  default = "SITE_TO_SITE_TUNNEL_IPSEC_OR_SSL"
}

# Azure

variable "azure_subscription_id" {
  type = string
  default = ""
}
variable "azure_client_id" {
  type = string
  default = ""
}
variable "azure_client_secret" {
  type = string
  default = ""
}
variable "azure_tenant_id" {
  type = string
  default = ""
}
variable "azure_disk_size" {
  type = number
  default = 80
}

variable "azure_region" {}
variable "azure_owner_tag" {}
variable "azure_image_name" {}
variable "azure_storage_account" {}
variable "azure_storage_account_rg" {}
variable "azure_sku_flavor" {}
