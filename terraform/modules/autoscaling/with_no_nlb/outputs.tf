output "asg_id" {
  description = "The ID of the Auto Scaling Group."
  value       = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.id}"
}
output "asg_name" {
  description = "The name of the Auto Scaling Group."
  value       = "${aws_autoscaling_group.icfar-asg-ec2-hostgroup.name}"
}