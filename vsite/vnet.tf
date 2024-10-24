resource "azurerm_virtual_network" "vnet" {
  name                = format("%s-vnet", var.f5xc_vsite_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [ var.vnet_cidr_block ]
  tags = {
    Name    = format("%s-gw", var.f5xc_vsite_name)
    Creator = var.azure_owner_tag
  }
}

resource "azurerm_subnet" "slo" {
  name                = format("%s-slo-subnet", var.f5xc_vsite_name)
  virtual_network_name = resource.azurerm_virtual_network.vnet.name
  address_prefixes     = var.azure_slo_subnets
  resource_group_name = var.resource_group_name
  private_endpoint_network_policies = "NetworkSecurityGroupEnabled"
}

resource "azurerm_subnet" "sli" {
  name                = format("%s-sli-subnet", var.f5xc_vsite_name)
  virtual_network_name = resource.azurerm_virtual_network.vnet.name
  address_prefixes     = var.azure_sli_subnets
  resource_group_name = var.resource_group_name
  private_endpoint_network_policies = "NetworkSecurityGroupEnabled"
}

resource "azurerm_subnet_network_security_group_association" "vsite_slo" {
  subnet_id                 = azurerm_subnet.slo.id
  network_security_group_id = azurerm_network_security_group.external.id
}

resource "azurerm_subnet_network_security_group_association" "vsite_sli" {
  subnet_id                 = azurerm_subnet.sli.id
  network_security_group_id = azurerm_network_security_group.external.id
}

resource "azurerm_network_security_group" "external" {
  name                = format("%s-external-network-sg", var.f5xc_vsite_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "icmp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ipsec"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "4500"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "tcpPort80"
    priority                   = 112
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Name    = format("%s-gw", var.f5xc_vsite_name)
    Creator = var.azure_owner_tag
  }
}

output "vnet" {
  value = resource.azurerm_virtual_network.vnet
}
