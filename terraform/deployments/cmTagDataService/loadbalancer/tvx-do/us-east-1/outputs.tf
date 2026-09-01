output "instance_ips" {
  value = "${module.ci-east-cmtagds.single_subnet_instance_ips}"
}