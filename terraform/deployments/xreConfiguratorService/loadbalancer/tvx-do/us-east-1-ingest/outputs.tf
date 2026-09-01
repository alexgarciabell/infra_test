output "instance_ips" {
  value = "${module.ci-east-configds.single_subnet_instance_ips}"
}