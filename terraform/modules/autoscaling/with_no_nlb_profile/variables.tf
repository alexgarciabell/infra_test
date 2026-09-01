variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "aws_instance_type" {
  description = "Instance type for the application to run"
  default     = "c5.xlarge"
}

variable "aws_security_groups" {
  description = "Security groups for launch template"
  type        = "list"
}

variable "data_center" {
  description = "datacenter in instance"
}

variable "domain" {
  description = "Domain of host"
}

variable "user_data" {
  description = "user data"
}

variable "min_size" {
  description = "min size for the autoscaling group"
}

variable "max_size" {
  description = "max size for the autoscaling group"
}

variable "desired_capacity" {
  description = "desired size for the autoscaling group"
}

variable "cpu_min" {
  description = "min size for the autoscaling group"
}

variable "cpu_max" {
  description = "max size for the autoscaling group"
}

variable "comcast_application_env" {
  description = "Environment where the resource is located (ci, prod, dev) (Used for resource ownership)"
}

variable "comcast_application_name" {
  description = "Base name of the service (eg. ads, eps, tagging_service) (Used for resource ownership)"
}

variable "comcast_application_role" {
  description = "General description of the resource type (eg. Application, Database, LoadBalancer, Storage) (Used for resource ownership)"
}

variable "comcast_iop_appid" {
  description = "DevHub id of the service (the IOP sys_id of the service can also be used) (Used for resource ownership)"
  default = ""
}

variable "name" {
  description = "Hostname of instance"
  default     = "asg"
}

variable "health_check_type" {
  description = "Controls how health checking is done"
  default     = "EC2"
}

variable "deployment_type" {
  description = "The strategy used to deploy the instance"
  default     = "XVP CS Terraform"
}

# not in use ?
#variable "application_port" {
#  description = "port for the application to run on"
#}

# not in use ?
#variable "aws_vpc" {
#  description = " AWS VPC ID"
#}

variable "aws_subnets" {
  description = "AWS subnet IDs"
  type        = "list"
}

variable "description" {
  description = "description about release"
  default     = ""
}

variable "application_version" {
  description = "version of application"
  default     = ""
}

variable "version_id" {
  description = "Version and iteration of service"
  default     = ""
}

variable "aws_profile" {
  description = "Notes what AWS profile to use for the credentials"
  default = "NA"
}

variable "iam_instance_profile" {
  description = "Used to set an IAM Profile to EC2 instances"
  default = "TaggingRole"
}

variable "comcast_service_name" {
  description = "Service name for AMi and Hostname Name Convention"
}