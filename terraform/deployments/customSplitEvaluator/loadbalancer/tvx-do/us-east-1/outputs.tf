output "instance_ips" {
  value = "${module.ci-east-cseval.single_subnet_instance_ips}"
}