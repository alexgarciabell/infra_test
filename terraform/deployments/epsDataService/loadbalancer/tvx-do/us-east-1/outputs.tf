output "instance_ips" {
  value = "${module.ci-east-epsds.single_subnet_instance_ips}"
}