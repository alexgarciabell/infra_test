output deployment_ids {
    value = module.prod-chicago-tagds.deployment_ids
}

output host_with_ip {
    value = module.prod-chicago-tagds.addresses_by_name
}

output hostlist {
    value = module.prod-chicago-tagds.host_list
}

output ips {
    value = module.prod-chicago-tagds.ip_list
}