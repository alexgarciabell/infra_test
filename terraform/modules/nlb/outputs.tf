output "nlb_id" {
  description = "The ID of the load balancer."
  value       = "${aws_lb.icfar-nlb.id}"
}
output "nlb_name" {
  description = "The name of the load balancer."
  value       = "${aws_lb.icfar-nlb.name}"
}
output "nlb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = "${aws_lb.icfar-nlb.dns_name}"
}
output "target_group_name" {
  description = "Name of the target group."
  value       = "${aws_lb_target_group.icfar-tg.name}"
}