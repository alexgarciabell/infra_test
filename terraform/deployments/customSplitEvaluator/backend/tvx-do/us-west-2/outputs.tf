output "single_subnet_instance_ips" {
  value = "${module.ci-west-cseval.single_subnet_instance_ips}"
}

output "multi_subnet_instance_ips" {
  value = "${module.ci-west-cseval.multi_subnet_instance_ips}"
}
