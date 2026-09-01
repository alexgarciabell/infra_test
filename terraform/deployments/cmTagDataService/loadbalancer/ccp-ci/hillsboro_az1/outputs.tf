output deployment_ids {
    value = module.ci-hillsboro-tagds.deployment_ids
}

output host_with_ip {
    value = module.ci-hillsboro-tagds.addresses_by_name
}

output hostlist {
    value = module.ci-hillsboro-tagds.host_list
}

output ips {
    value = module.ci-hillsboro-tagds.ip_list
}