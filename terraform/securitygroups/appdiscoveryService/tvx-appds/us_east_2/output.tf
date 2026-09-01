output "ads-backend-ohio" {
  value = "${aws_security_group.ads-backend-ohio.id}"
}

output "ads-haproxy-ohio" {
  value = "${aws_security_group.ads-haproxy-ohio.id}"
}