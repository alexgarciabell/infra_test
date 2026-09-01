output "single_subnet_instance_ips" {
  value = "${aws_instance.single_subnet_dataService_instance.*.private_ip}"
}

output "multi_subnet_instance_ips" {
  value = "${aws_instance.multi_subnet_dataService_instance.*.private_ip}"
}