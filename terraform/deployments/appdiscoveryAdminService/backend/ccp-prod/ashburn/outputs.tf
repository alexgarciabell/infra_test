output deployment_ids {
    value = module.ccp-prod-as-adsadmin.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-as-adsadmin.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-as-adsadmin.host_list
}

output ips {
    value = module.ccp-prod-as-adsadmin.ip_list
}