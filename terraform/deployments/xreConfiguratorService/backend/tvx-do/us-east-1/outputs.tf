output "single_subnet_instance_ips" {
  value = "${module.ci-east-configds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-east-configds.multi_subnet_instance_ips}"
}