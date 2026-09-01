output "instance_ips" {
  value = "${module.ci-west-cseval.single_subnet_instance_ips}"
}