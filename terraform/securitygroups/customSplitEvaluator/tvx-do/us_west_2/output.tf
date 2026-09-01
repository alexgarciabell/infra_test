output "cseval-backend-west" {
  value = "${aws_security_group.cseval-backend-west.id}"
}

output "cseval-haproxy-west" {
  value = "${aws_security_group.cseval-haproxy-west.id}"
}