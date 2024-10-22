resource "azurerm_resource_group" "rg" {
  name     = format("%s-vsite-lab-rg", var.project_prefix)
  location = var.azure_region
}

