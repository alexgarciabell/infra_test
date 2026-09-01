output "instance_ips" {
  value = "${module.ci-west-configds.single_subnet_instance_ips}"
}