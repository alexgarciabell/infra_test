output "nlb_id" {
  description = "The ID of the NLB."
  value       = "${module.prod-west-customSplitEvaluator-nlb.nlb_id}"
}
output "nlb_name" {
  description = "The name of the NLB."
  value       = "${module.prod-west-customSplitEvaluator-nlb.nlb_name}"
}
output "nlb_dns_name" {
  description = "The dns name of the NLB."
  value       = "${module.prod-west-customSplitEvaluator-nlb.nlb_dns_name}"
}
output "target_group_name" {
  description = "The name of the targetgroup name."
  value       = "${module.prod-west-customSplitEvaluator-nlb.target_group_name}"
}
