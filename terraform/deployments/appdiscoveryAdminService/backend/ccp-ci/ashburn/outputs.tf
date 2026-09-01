output deployment_ids {
    value = module.ccp-ci-as-adsadmin.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-as-adsadmin.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-as-adsadmin.host_list
}

output ips {
    value = module.ccp-ci-as-adsadmin.ip_list
}