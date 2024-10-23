module "azure-node" {
  count                        = length(var.azure_availability_zones)
  source                       = "./azure"
  f5xc_cluster_name            = format("%s%s",var.f5xc_vsite_name, element(var.azure_availability_zones, count.index))
  f5xc_virtual_site            = var.f5xc_vsite_name
  azure_subscription_id        = var.azure_subscription_id
  ssh_public_key               = var.ssh_public_key

  azure_sku_flavor             = var.azure_sku_flavor
  azure_disk_size              = var.azure_disk_size

  resource_group_name          = var.resource_group_name
  resource_group_location      = var.resource_group_location
  azure_availability_zone      = element(var.azure_availability_zones, count.index)
  azure_image_name             = var.azure_image_name
  azure_storage_account        = var.azure_storage_account
  azure_storage_account_rg     = var.azure_storage_account_rg
  azure_slo_subnet_id          = resource.azurerm_subnet.slo.id
  azure_sli_subnet_id          = resource.azurerm_subnet.sli.id
  azure_owner_tag              = var.azure_owner_tag
  azure_sli_workload_ip        = var.azure_sli_workload_ip[count.index]
  f5xc_tunnel_type             = var.f5xc_tunnel_type
  backend_address_pool_slo_id  = azurerm_lb_backend_address_pool.slo.id
  backend_address_pool_sli_id  = azurerm_lb_backend_address_pool.sli.id

  azure_network_security_group_id = resource.azurerm_network_security_group.external.id
}
