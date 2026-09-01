output deployment_ids {
    value = module.prod-hillsboro-tagds.deployment_ids
}

output host_with_ip {
    value = module.prod-hillsboro-tagds.addresses_by_name
}

output hostlist {
    value = module.prod-hillsboro-tagds.host_list
}

output ips {
    value = module.prod-hillsboro-tagds.ip_list
}