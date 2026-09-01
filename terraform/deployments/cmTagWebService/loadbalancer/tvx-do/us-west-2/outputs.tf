output "instance_ips" {
  value = "${module.ci-west-cmtagws.single_subnet_instance_ips}"
}