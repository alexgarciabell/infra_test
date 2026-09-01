output deployment_ids {
    value = module.ccp-prod-ho-tagds.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-ho-tagds.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-ho-tagds.host_list
}

output ips {
    value = module.ccp-prod-ho-tagds.ip_list
}