output "cseval-backend-east" {
  value = "${module.prod-cseval-east.cseval-backend-east}"
}

output "cseval-backend-ohio" {
  value = "${module.prod-cseval-ohio.cseval-backend-ohio}"
}

output "cseval-backend-west" {
  value = "${module.prod-cseval-west.cseval-backend-west}"
}

output "cseval-haproxy-east" {
  value = "${module.prod-cseval-east.cseval-haproxy-east}"
}

output "cseval-haproxy-ohio" {
  value = "${module.prod-cseval-ohio.cseval-haproxy-ohio}"
}

output "cseval-haproxy-west" {
  value = "${module.prod-cseval-west.cseval-haproxy-west}"
}
