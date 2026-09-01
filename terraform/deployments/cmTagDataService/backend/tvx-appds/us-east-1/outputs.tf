output "single_subnet_instance_ips" {
  value = "${module.prod-east-cmTagDataService.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-east-cmTagDataService.multi_subnet_instance_ips}"
}