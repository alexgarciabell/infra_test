output "single_subnet_instance_ips" {
  value = "${module.prod-west-cmTagWebService.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-west-cmTagWebService.multi_subnet_instance_ips}"
}