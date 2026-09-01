output "single_subnet_instance_ips" {
  value = "${module.prod-west-cmTagDataService.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-west-cmTagDataService.multi_subnet_instance_ips}"
}