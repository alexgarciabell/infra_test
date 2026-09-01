output deployment_ids {
    value = module.ccp-prod-ho-tagui.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-ho-tagui.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-ho-tagui.host_list
}

output ips {
    value = module.ccp-prod-ho-tagui.ip_list
}