output deployment_ids {
    value = module.prod-ashburn-adsds.deployment_ids
}

output host_with_ip {
    value = module.prod-ashburn-adsds.addresses_by_name
}

output hostlist {
    value = module.prod-ashburn-adsds.host_list
}

output ips {
    value = module.prod-ashburn-adsds.ip_list
}