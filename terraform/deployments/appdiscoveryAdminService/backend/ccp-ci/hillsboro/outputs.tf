output deployment_ids {
    value = module.ccp-ci-ho-adsadmin.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-ho-adsadmin.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-ho-adsadmin.host_list
}

output ips {
    value = module.ccp-ci-ho-adsadmin.ip_list
}