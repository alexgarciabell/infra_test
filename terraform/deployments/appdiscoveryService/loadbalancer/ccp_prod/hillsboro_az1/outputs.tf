output deployment_ids {
    value = module.prod-hillsboro-adsds.deployment_ids
}

output host_with_ip {
    value = module.prod-hillsboro-adsds.addresses_by_name
}

output hostlist {
    value = module.prod-hillsboro-adsds.host_list
}

output ips {
    value = module.prod-hillsboro-adsds.ip_list
}