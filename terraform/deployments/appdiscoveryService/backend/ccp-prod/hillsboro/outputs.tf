output deployment_ids {
    value = module.ccp-prod-ho-adsds.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-ho-adsds.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-ho-adsds.host_list
}

output ips {
    value = module.ccp-prod-ho-adsds.ip_list
}