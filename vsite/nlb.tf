resource "azurerm_lb" "lb" {
  sku                 = "Standard"
  name                = format("%s-lb", var.f5xc_vsite_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  # frontend_ip_configuration {
  #   name                 = "slo-public"
  #   public_ip_address_id = azurerm_public_ip.nlb.id
  # }

  frontend_ip_configuration {
      name      = "slo"
      subnet_id = azurerm_subnet.slo.id
  }

  frontend_ip_configuration {
      name      = "sli"
      subnet_id = azurerm_subnet.sli.id
  }
 }

resource "azurerm_lb_backend_address_pool" "slo" {
  name            = format("%s-slo-lb-pool", var.f5xc_vsite_name)
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_backend_address_pool" "sli" {
  name            = format("%s-sli-lb-pool", var.f5xc_vsite_name)
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe_slo" {
  port            = var.f5xc_ce_slo_probe_port
  name            = format("%s-lb-probe-tcp-%s", var.f5xc_vsite_name, var.f5xc_ce_slo_probe_port)
  protocol        = "Tcp"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "probe_sli" {
  port            = var.f5xc_ce_sli_probe_port
  name            = format("%s-lb-probe-tcp-%s", var.f5xc_vsite_name, var.f5xc_ce_sli_probe_port)
  protocol        = "Tcp"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_lb_rule" "slo" {
  name                           = format("%s-slo-lb-rule", var.f5xc_vsite_name)
  probe_id                       = azurerm_lb_probe.probe_slo.id
  protocol                       = "All"
  backend_port                   = 0
  frontend_port                  = 0
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.slo.id]
  frontend_ip_configuration_name = "slo"
}

resource "azurerm_lb_rule" "sli" {
  name                           = format("%s-sli-lb-rule", var.f5xc_vsite_name)
  probe_id                       = azurerm_lb_probe.probe_sli.id
  protocol                       = "All"
  backend_port                   = 0
  frontend_port                  = 0
  loadbalancer_id                = azurerm_lb.lb.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.sli.id]
  frontend_ip_configuration_name = "sli"
}

resource "azurerm_public_ip" "nlb" {
  name                = format("%s-slo-nlb-public-ip", var.f5xc_vsite_name)
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

output "nlb" {
  value = azurerm_lb.lb
}
