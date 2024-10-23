output "workload_ip_address" {
    value = {
    "${azurerm_linux_virtual_machine.master_vm.name}-slo" = azurerm_network_interface.master_vm_slo.private_ip_address,
    "${azurerm_linux_virtual_machine.master_vm.name}-sli" = azurerm_network_interface.master_vm_sli.private_ip_address,
    "${azurerm_linux_virtual_machine.master_vm.name}-public" = azurerm_public_ip.master_vm.ip_address,
    "${azurerm_virtual_machine.workload_vm.name}" = azurerm_public_ip.workload.ip_address
  }
}
