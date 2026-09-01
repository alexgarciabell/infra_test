output "instance_ips" {
  value = "${module.ci-west-epsds.single_subnet_instance_ips}"
}