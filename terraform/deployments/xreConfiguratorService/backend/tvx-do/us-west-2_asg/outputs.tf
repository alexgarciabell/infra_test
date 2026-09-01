output "asg_id" {
  description = "The ID of the Auto Scaling Group."
  value       = module.ci-autoscaling-west-configds.asg_id
}
output "asg_name" {
  description = "The ID of the Auto Scaling Group."
  value       = module.ci-autoscaling-west-configds.asg_name
}