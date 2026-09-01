output "single_subnet_instance_ips" {
  value = "${module.ci-west-configds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-west-configds.multi_subnet_instance_ips}"
}
