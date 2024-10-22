resource "azurerm_public_ip" "master_vm" {
  name                = format("%s-master_vm-public-ip", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Creator = var.azure_owner_tag
  }
}

resource "azurerm_network_interface" "master_vm_slo" {
  name                = format("%s-slo-master_vm-nic", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name                          = "slo"
    subnet_id                     = var.azure_slo_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master_vm.id
  }
}

resource "azurerm_network_interface" "master_vm_sli" {
  name                = format("%s-sli-master_vm-nic", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name                          = "sli"
    subnet_id                     = var.azure_sli_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "master_vm" {
  name                  = format("%s-m0", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = var.azure_sku_flavor
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.master_vm_slo.id,
    azurerm_network_interface.master_vm_sli.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.azure_disk_size
  }

  source_image_id = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_storage_account_rg}/providers/Microsoft.Compute/images/${var.azure_image_name}"

  custom_data    = base64encode(templatefile("${path.module}/templates/cloud-config-base.tmpl", {
    ssh_public_key = var.ssh_public_key,
    node_registration_token = terraform_data.token.input
  }))

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.ssh_public_key
  }
}
