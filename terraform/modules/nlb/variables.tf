variable "aws_region" {
  description = "AWS region to launch servers."
  default     = ""
}

variable "aws_vpc" {
  description = " AWS VPC ID"
}

variable "aws_subnets" {
  description = "AWS subnet IDs"
  type        = "list"
}

variable "comcast_application_env" {
  description = "Environment where the resource is located (ci, prod, dev) (Used for resource ownership)"
}

variable "comcast_application_name" {
  description = "Base name of the service (eg. ads, eps, tagging_service) (Used for resource ownership)"
}

variable "comcast_application_role" {
  description = "General description of the resource type (eg. Application, Database, LoadBalancer, Storage) (Used for resource ownership)"
  default = "LoadBalancer"
}

variable "comcast_iop_appid" {
  description = "DevHub id of the service (the IOP sys_id of the service can also be used) (Used for resource ownership)"
  default = ""
}

variable "application_port" {
  description = "port for the application to run on"
}

variable "description" {
  description = "description about release"
}

variable "deployment_type" {
  description = "The strategy used to deploy the instance"
  default     = "XVP CS Terraform"
}

variable "enable_deletion_protection" {
  description = "Deletion protection for network load balancer"
  default     = true
}

variable "enable_cross_zone_load_balancing" {
  description = "The cross-zone load balancing of the network load balancer will be enabled"
  default     = true
}

variable "health_api" {
  description = "API for the service's healthcheck/heartbeat"
  default = "/heartBeat"
}

variable "hc_call_protocol" {
  description = "Protocol the load balancer uses when performing health checks on targets (Values: TCP, HTTP, HTTPS)"
  default = "HTTP"
}

variable "iteration" {
  description = "suffix of the nlb name"
  type        = number
  default     = "1"
}