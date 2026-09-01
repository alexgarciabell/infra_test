output deployment_ids {
    value = module.ccp-prod-as-adsds.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-as-adsds.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-as-adsds.host_list
}

output ips {
    value = module.ccp-prod-as-adsds.ip_list
}