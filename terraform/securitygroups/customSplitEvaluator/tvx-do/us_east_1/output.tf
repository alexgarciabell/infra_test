output "cseval-backend-east" {
  value = "${aws_security_group.cseval-backend-east.id}"
}

output "cseval-haproxy-east" {
  value = "${aws_security_group.cseval-haproxy-east.id}"
}
