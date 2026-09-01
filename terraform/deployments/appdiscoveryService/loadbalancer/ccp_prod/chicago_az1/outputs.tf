output deployment_ids {
    value = module.prod-chicago-adsds.deployment_ids
}

output host_with_ip {
    value = module.prod-chicago-adsds.addresses_by_name
}

output hostlist {
    value = module.prod-chicago-adsds.host_list
}

output ips {
    value = module.prod-chicago-adsds.ip_list
}