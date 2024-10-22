output "vsite1" {
  value = module.vsite1
  sensitive = true
}

#output "vsite2" {
#  value = module.vsite2
#  sensitive = true
#}

output "ip_address" {
  value = flatten(concat(
    #    module.vsite2[*].node.azure[*].ip_address,
    #    module.vsite1[*].node.azure[*].ip_address,
    module.vsite1[*].node.azure[*].workload_ip_address,
    module.vsite2[*].node.azure[*].workload_ip_address
  ))
}

