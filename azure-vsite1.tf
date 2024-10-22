module "vsite1" {
  source                    = "./vsite"
  f5xc_vsite_name           = format("%s-azure-vsite-1", var.project_prefix)
  resource_group_name       = resource.azurerm_resource_group.rg.name
  resource_group_location   = resource.azurerm_resource_group.rg.location
  azure_subscription_id     = var.azure_subscription_id

  ssh_public_key            = var.ssh_public_key
  azure_storage_account     = var.azure_storage_account
  azure_storage_account_rg  = var.azure_storage_account_rg
  azure_image_name          = var.azure_image_name
  azure_disk_size           = var.azure_disk_size
  azure_sku_flavor          = var.azure_sku_flavor

  vnet_cidr_block           = "10.1.0.0/16"
  azure_availability_zones  = [ "1", "2" ]
  azure_slo_subnets         = [ "10.1.1.0/24" ]
  azure_sli_subnets         = [ "10.1.11.0/24" ]
  azure_sli_workload_ip     = [ "10.1.11.100", "10.1.11.101" ]
  azure_owner_tag           = var.azure_owner_tag

  f5xc_tunnel_type          = var.f5xc_tunnel_type
  f5xc_tenant               = var.f5xc_tenant
  f5xc_api_url              = var.f5xc_api_url
  f5xc_api_token            = var.f5xc_api_token
}
