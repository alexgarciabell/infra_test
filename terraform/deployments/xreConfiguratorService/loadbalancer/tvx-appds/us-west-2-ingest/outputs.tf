output "instance_ips" {
  value = "${module.prod-west-configds-ingest.single_subnet_instance_ips}"
}