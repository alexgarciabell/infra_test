output "instance_ips" {
  value = "${module.prod-east-epsds.single_subnet_instance_ips}"
}