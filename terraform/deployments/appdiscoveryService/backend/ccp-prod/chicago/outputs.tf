output deployment_ids {
    value = module.ccp-prod-ch-adsds.deployment_ids
}

output host_with_ip {
    value = module.ccp-prod-ch-adsds.addresses_by_name
}

output hostlist {
    value = module.ccp-prod-ch-adsds.host_list
}

output ips {
    value = module.ccp-prod-ch-adsds.ip_list
}