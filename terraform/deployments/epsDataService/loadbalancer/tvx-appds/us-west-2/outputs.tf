output "instance_ips" {
  value = "${module.prod-west-epsds.single_subnet_instance_ips}"
}