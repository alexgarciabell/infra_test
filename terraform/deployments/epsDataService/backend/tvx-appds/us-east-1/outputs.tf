output "single_subnet_instance_ips" {
  value = "${module.prod-east-epsds.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-east-epsds.multi_subnet_instance_ips}"
}