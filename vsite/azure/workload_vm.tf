resource "azurerm_public_ip" "workload" {
  name                = format("%s-workload-public-ip", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    Creator = var.azure_owner_tag
  }
}

resource "azurerm_network_interface" "workload" {
  name                = format("%s-sli-workload-nic", var.f5xc_cluster_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = var.azure_sli_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.azure_sli_workload_ip
    public_ip_address_id          = azurerm_public_ip.workload.id

  }
}

resource "azurerm_virtual_machine" "workload_vm" {
  name                  = format("%s-sli-workload", var.f5xc_cluster_name)
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.workload.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  storage_os_disk {
    name              = format("%s-sli-workload", var.f5xc_cluster_name)
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = format("%s-sli-workload", var.f5xc_cluster_name)
    admin_username = "ubuntu"
    custom_data    = templatefile("${path.module}/templates/ubuntu_workload.tmpl", {
      ssh_public_key = var.ssh_public_key
    })
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.ssh_public_key
      path     = "/home/ubuntu/.ssh/authorized_keys"
    }
  }
  tags = {
    Creator = var.azure_owner_tag
  }
}

