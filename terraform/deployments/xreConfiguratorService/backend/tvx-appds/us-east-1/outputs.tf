output "single_subnet_instance_ips" {
  value = "${module.prod-east-configds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-east-configds.multi_subnet_instance_ips}"
}