output "ads-backend-east" {
  value = "${module.prod-ads-east.ads-backend-east}"
}

output "ads-backend-ohio" {
  value = "${module.prod-ads-ohio.ads-backend-ohio}"
}

output "ads-backend-west" {
  value = "${module.prod-ads-west.ads-backend-west}"
}

output "ads-haproxy-east" {
  value = "${module.prod-ads-east.ads-haproxy-east}"
}

output "ads-haproxy-ohio" {
  value = "${module.prod-ads-ohio.ads-haproxy-ohio}"
}

output "ads-haproxy-west" {
  value = "${module.prod-ads-west.ads-haproxy-west}"
}
