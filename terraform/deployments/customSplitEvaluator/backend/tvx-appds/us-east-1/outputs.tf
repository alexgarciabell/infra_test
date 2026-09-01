output "single_subnet_instance_ips" {
  value = "${module.prod-east-cseval.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.prod-east-cseval.multi_subnet_instance_ips}"
}