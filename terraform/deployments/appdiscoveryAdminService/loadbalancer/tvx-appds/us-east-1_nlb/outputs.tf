output "nlb_id" {
  description = "The ID of the NLB."
  value       = "${module.prod-east-adsadmin-nlb.nlb_id}"
}
output "nlb_name" {
  description = "The name of the NLB."
  value       = "${module.prod-east-adsadmin-nlb.nlb_name}"
}
output "nlb_dns_name" {
  description = "The dns name of the NLB."
  value       = "${module.prod-east-adsadmin-nlb.nlb_dns_name}"
}
output "target_group_name" {
  description = "The name of the targetgroup name."
  value       = "${module.prod-east-adsadmin-nlb.target_group_name}"
}
