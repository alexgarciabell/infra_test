output deployment_ids {
    value = module.ccp-ci-ho-adsds.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-ho-adsds.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-ho-adsds.host_list
}

output ips {
    value = module.ccp-ci-ho-adsds.ip_list
}