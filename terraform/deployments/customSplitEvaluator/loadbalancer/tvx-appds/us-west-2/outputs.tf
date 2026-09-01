output "instance_ips" {
  value = "${module.prod-west-cseval.single_subnet_instance_ips}"
}