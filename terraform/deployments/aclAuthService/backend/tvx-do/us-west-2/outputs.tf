output "single_subnet_instance_ips" {
  value = "${module.ci-west-aclauth.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-west-aclauth.multi_subnet_instance_ips}"
}
