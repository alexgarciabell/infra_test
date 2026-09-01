output deployment_ids {
    value = module.ccp-prod-as-tagui.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-as-tagui.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-as-tagui.host_list
}

output ips {
    value = module.ccp-prod-as-tagui.ip_list
}