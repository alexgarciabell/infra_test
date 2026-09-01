output "instance_ips" {
  value = "${module.prod-east-cmtagws.single_subnet_instance_ips}"
}