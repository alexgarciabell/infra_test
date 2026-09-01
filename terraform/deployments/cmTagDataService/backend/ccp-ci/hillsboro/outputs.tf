output deployment_ids {
    value = module.ccp-ci-ho-tagds.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-ho-tagds.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-ho-tagds.host_list
}

output ips {
    value = module.ccp-ci-ho-tagds.ip_list
}