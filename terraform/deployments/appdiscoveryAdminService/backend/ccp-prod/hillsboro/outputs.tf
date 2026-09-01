output deployment_ids {
    value = module.ccp-prod-ho-adsadmin.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-ho-adsadmin.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-ho-adsadmin.host_list
}

output ips {
    value = module.ccp-prod-ho-adsadmin.ip_list
}