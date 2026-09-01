output deployment_ids {
    value = module.ccp-ci-ho-tagui.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-ho-tagui.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-ho-tagui.host_list
}

output ips {
    value = module.ccp-ci-ho-tagui.ip_list
}