output "instance_ips" {
  value = "${module.prod-west-cmtagds.single_subnet_instance_ips}"
}