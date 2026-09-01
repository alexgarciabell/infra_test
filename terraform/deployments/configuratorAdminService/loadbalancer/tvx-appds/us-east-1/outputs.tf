output "instance_ips" {
  value = "${module.prod-east-configadmin.single_subnet_instance_ips}"
}