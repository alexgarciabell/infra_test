output "instance_ips" {
  value = "${module.prod-east-cseval.single_subnet_instance_ips}"
}