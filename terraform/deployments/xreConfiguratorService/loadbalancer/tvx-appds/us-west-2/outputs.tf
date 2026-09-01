output "instance_ips" {
  value = "${module.prod-west-configds.single_subnet_instance_ips}"
}