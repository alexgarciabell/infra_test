output "addresses_by_name" {
    description = "Resource name and IP addresses of all machines from an xCloud deployment"
    value = local.vm_name_with_ip
}

output "deployment_ids" {
    description = "ID Value for the Deployment.  Use as reference for adding machines to the deployment."
    value = vra_deployment.this[*].id
}

output "host_list" {
    description = "List of hostnames created in the deployment"
    value = local.vm_names
}

output "ip_list" {
    description = "List of IP addresses used in the deployment"
    value = local.ip_addresses
}

#output "ipv6_list" {
#    description = "List of IPv6 addresses used in the deployment"
#    value = local.v6_addresses
#}

#output "v6_addresses_by_name" {
#    description = "Resource name and v6 address"
#    value = local.vm_name_with_v6ip
#}
