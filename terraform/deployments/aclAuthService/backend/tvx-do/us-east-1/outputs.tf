output "single_subnet_instance_ips" {
  value = "${module.ci-east-aclauth.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-east-aclauth.multi_subnet_instance_ips}"
}