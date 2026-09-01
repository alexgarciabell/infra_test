output "single_subnet_instance_ips" {
  value = "${module.ci-east-cmTagDataService.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-east-cmTagDataService.multi_subnet_instance_ips}"
}