output "instance_ips" {
  value = "${module.prod-west-cmtagws.single_subnet_instance_ips}"
}