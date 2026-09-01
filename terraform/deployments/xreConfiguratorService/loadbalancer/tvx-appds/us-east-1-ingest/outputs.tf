output "instance_ips" {
  value = "${module.prod-east-configds-ingest.single_subnet_instance_ips}"
}