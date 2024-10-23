resource "azurerm_network_interface_backend_address_pool_association" "slo" {
  network_interface_id    = azurerm_network_interface.master_vm_slo.id
  ip_configuration_name   = "slo"
  backend_address_pool_id = var.backend_address_pool_slo_id
}

resource "azurerm_network_interface_backend_address_pool_association" "sli" {
  network_interface_id    = azurerm_network_interface.master_vm_sli.id
  ip_configuration_name   = "sli"
  backend_address_pool_id = var.backend_address_pool_sli_id
}
