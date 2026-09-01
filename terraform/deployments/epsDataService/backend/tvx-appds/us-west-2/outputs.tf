output "single_subnet_instance_ips" {
  value = "${module.prod-west-epsds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-west-epsds.multi_subnet_instance_ips}"
}