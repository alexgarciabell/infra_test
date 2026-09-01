output deployment_ids {
    value = module.ccp-ci-as-tagds.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-as-tagds.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-as-tagds.host_list
}

output ips {
    value = module.ccp-ci-as-tagds.ip_list
}