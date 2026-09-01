variable "aws_region" {
  description = "AWS Region the instance will exist in"
}

variable "data_center" {
  description = "The datacenter the instance will exist in (used by the service)"
}

variable "multi_subnet_instance_count" {
  description = "Number of EC2 instances to launch across more than 1 available subnets in VPC"
  default     = 0
}

variable "single_subnet_instance_count" {
  description = "Number of EC2 instances to launch in a single subnet in VPC"
  default     = 0
}

variable "subnet_id" {
  description = "Subnet ID to launch instance in; must be in the same VPC as in vpc_id (needed only if using single_subnet_instance_count)"
  default = ""
}

variable "instance_type" {
  description = "EC2 Instance Type to use"
  default     = "c5.xlarge"
}

variable "user_data" {
  description = "Terraform userdata file for the service and environment"
}

variable "key_pair" {
  description = "The SSH keypair to attach to the instance"
}

variable "termination_protection" {
  description = "Whether to use termination protection for the instances"
  default     = false
}

variable "vpc_id" {
  description = "VPC ID to launch instance in"
}

variable "name" {
  description = "Prefix of the hostname of instance"
  default     = "xvpsvc"
}

variable "domain" {
  description = "Base endpoint domain of host (used for hostname)"
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

variable "deployment_type" {
  description = "The deployment strategy used for the instance creation"
  default     = "XVP CS Terraform"
}

variable "security_groups" {
  type        = "list"
  description = "AWS Security Groups that are attached to the instances"
}

variable "env_certs" {
  description = "Flag to determine whether to use service SSL certificates that are per environment (eg. ci and prod)"
  default = "true"
}

variable "comcast_service_name" {
  description = "Service name for AMI and Hostname naming convention (used internally; compliment to comcast_application_role)"
}

variable "role_id" {
  description = "RoleID for Vault authentication"
}

variable "secret_id" {
  description = "SecretID for Vault authentication"
}
