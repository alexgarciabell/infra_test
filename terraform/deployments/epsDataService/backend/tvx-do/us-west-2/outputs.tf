output "single_subnet_instance_ips" {
  value = "${module.ci-west-epsds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-west-epsds.multi_subnet_instance_ips}"
}
