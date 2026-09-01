output "instance_id" {
  description = "The ID of the Instance."
  value       = aws_instance.icfar-ec2-tspadmin.id
}
output "instance_name" {
  description = "The name of the Instance."
  value       = aws_instance.icfar-ec2-tspadmin.tags["Name"]
}
output "instance_ip" {
  description = "The IP of the Instance."
  value       = aws_instance.icfar-ec2-tspadmin.private_ip
}
