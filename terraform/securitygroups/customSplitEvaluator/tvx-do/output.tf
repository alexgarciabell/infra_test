output "cseval-backend-east" {
  value = "${module.ci-cseval-east.cseval-backend-east}"
}

output "cseval-backend-west" {
  value = "${module.ci-cseval-west.cseval-backend-west}"
}

output "cseval-haproxy-east" {
  value = "${module.ci-cseval-east.cseval-haproxy-east}"
}

output "cseval-haproxy-west" {
  value = "${module.ci-cseval-west.cseval-haproxy-west}"
}
