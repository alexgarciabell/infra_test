output "ads-backend-west" {
  value = "${aws_security_group.ads-backend-west.id}"
}

output "ads-haproxy-west" {
  value = "${aws_security_group.ads-haproxy-west.id}"
}