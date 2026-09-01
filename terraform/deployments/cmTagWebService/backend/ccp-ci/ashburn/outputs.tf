output deployment_ids {
    value = module.ccp-ci-as-tagui.deployment_ids
}

output host_with_ip {
    value = module.ccp-ci-as-tagui.addresses_by_name
}

output hostlist {
    value = module.ccp-ci-as-tagui.host_list
}

output ips {
    value = module.ccp-ci-as-tagui.ip_list
}