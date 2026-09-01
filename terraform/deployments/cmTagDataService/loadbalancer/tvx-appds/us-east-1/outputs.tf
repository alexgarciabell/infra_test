output "instance_ips" {
  value = "${module.prod-east-cmtagds.single_subnet_instance_ips}"
}