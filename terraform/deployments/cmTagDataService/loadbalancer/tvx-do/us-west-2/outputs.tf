output "instance_ips" {
  value = "${module.ci-west-cmtagds.single_subnet_instance_ips}"
}