output "instance_ips" {
  value = "${module.prod-west-configadmin.single_subnet_instance_ips}"
}