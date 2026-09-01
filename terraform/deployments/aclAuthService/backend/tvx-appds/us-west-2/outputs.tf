output "single_subnet_instance_ips" {
  value = "${module.prod-west-aclauth.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-west-aclauth.multi_subnet_instance_ips}"
}