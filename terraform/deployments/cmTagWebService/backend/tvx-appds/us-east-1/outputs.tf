output "single_subnet_instance_ips" {
  value = "${module.prod-east-cmTagWebService.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-east-cmTagWebService.multi_subnet_instance_ips}"
}