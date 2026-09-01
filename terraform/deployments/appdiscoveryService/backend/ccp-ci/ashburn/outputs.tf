output deployment_ids {
    value = module.ccp-ci-as-adsds.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-as-adsds.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-as-adsds.host_list
}

output ips {
    value = module.ccp-ci-as-adsds.ip_list
}