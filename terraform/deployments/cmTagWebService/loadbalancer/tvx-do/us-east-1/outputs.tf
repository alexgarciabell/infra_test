output "instance_ips" {
  value = "${module.ci-east-cmtagws.single_subnet_instance_ips}"
}