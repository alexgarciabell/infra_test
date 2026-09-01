output deployment_ids {
    value = module.prod-ashburn-tagds.deployment_ids
}

output host_with_ip {
    value = module.prod-ashburn-tagds.addresses_by_name
}

output hostlist {
    value = module.prod-ashburn-tagds.host_list
}

output ips {
    value = module.prod-ashburn-tagds.ip_list
}