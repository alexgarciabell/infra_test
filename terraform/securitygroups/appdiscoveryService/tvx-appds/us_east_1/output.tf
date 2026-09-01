output "ads-backend-east" {
  value = "${aws_security_group.ads-backend-east.id}"
}

output "ads-haproxy-east" {
  value = "${aws_security_group.ads-haproxy-east.id}"
}
