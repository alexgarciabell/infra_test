variable "aws_region" {
  description = "AWS region to launch servers."
}

variable "aws_instance_type" {
  description = "Instance type for the application to run"
  default     = "c5.xlarge"
}

variable "aws_security_groups" {
  description = "Security groups for launch template"
  type        = list(string)
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
  default     = "Instance"
}

variable "aws_subnets" {
  description = "AWS subnet IDs"
  type        = list(string)
}

variable "application_version" {
  description = "version of application"
  default     = ""
}

variable "version_id" {
  description = "Version and iteration of service"
  default     = ""
}

variable "iam_instance_profile" {
  description = "Used to set an IAM Profile to EC2 instances"
  default     = "TaggingRole"
}

variable "comcast_service_name" {
  description = "Service name for AMi and Hostname Name Convention"
}

variable "role_id" {
  description = "RoleID for Vault authentication"
  type = string
  default = "RoleID"

}

variable "secret_id" {
  description = "SecretID for Vault authentication"
  type = string
  default = "SecretID"
}
