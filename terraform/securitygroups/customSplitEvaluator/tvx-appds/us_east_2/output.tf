output "cseval-backend-ohio" {
  value = "${aws_security_group.cseval-backend-ohio.id}"
}

output "cseval-haproxy-ohio" {
  value = "${aws_security_group.cseval-haproxy-ohio.id}"
}