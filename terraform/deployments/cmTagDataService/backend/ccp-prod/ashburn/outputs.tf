output deployment_ids {
    value = module.ccp-prod-as-tagds.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-as-tagds.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-as-tagds.host_list
}

output ips {
    value = module.ccp-prod-as-tagds.ip_list
}