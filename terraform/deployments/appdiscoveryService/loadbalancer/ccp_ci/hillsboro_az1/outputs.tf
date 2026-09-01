output deployment_ids {
    value = module.ci-hillsboro-adsds.deployment_ids
}

output host_with_ip {
    value = module.ci-hillsboro-adsds.addresses_by_name
}

output hostlist {
    value = module.ci-hillsboro-adsds.host_list
}

output ips {
    value = module.ci-hillsboro-adsds.ip_list
}