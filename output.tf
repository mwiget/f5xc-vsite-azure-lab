# output "vsite1" {
#   value = module.vsite1
#   sensitive = true
# }

# output "vsite2" {
#   value = module.vsite2
#   sensitive = true
# }

output "ip_address" {
  value = flatten(concat(
    #    module.vsite2[*].node.azure[*].ip_address,
    #    module.vsite1[*].node.azure[*].ip_address,
    module.vsite1[*].node.azure[*].workload_ip_address,
    module.vsite2[*].node.azure[*].workload_ip_address
  ))
}

output "load_balancer" {
  value = {
    vsite1 = flatten(concat(module.vsite1.nlb.private_ip_addresses)),
    vsite2 = flatten(concat(module.vsite2.nlb.private_ip_addresses))
  }
}
