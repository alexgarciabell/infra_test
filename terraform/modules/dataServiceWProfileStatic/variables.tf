variable "aws_region" {
  description = "Region for instance to launch"
}

variable "data_center" {
  description = "datacenter in instance"
}

variable "multi_subnet_instance_count" {
  description = "Number of EC2 instances to launch across available subnets in VPC"
  default     = 0
}

variable "single_subnet_instance_count" {
  description = "Number of EC2 instances to launch in a single subnet"
  default     = 0
}

variable "subnet_id" {
  description = "Subnet ID to launch instance when only creating in a single subnet"
  default = ""
}

variable "instance_type" {
  description = "Instance Type"
}

variable "user_data" {
  description = "user data"
}

variable "key_pair" {
  description = "The key pair to attach to the instance"
}

variable "termination_protection" {
  description = "termination_protection attach to the instance"
  default     = false
}

variable "vpc_id" {
  description = "Subnet ID to launch instance"
}

variable "name" {
  description = "Hostname of instance"
  default     = "tvxads"
}

variable "domain" {
  description = "Domain of host"
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
  description = "The strategy used to deploy the instance"
  default     = "XVP CS Terraform"
}

variable "security_groups" {
  type        = "list"
  description = "Security groups attached to instance"
}

#gdejes200 - GDJ
#Note: This follows the profile convention from the AWS CLI. In order to use this, the profiles need to be set up for the
# user that's running it. By default, the profile information will be in ~/.aws. There are 2 files that are needed there:
#- credentials - This is where the profile information exists
#- configs - This lists the available profiles and other configs related to the AWS CLI
#Ref: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

variable "aws_profile" {
  description = "Notes what AWS profile to use for the credentials"
  default = "NA"
}

variable "iam_instance_profile" {
  description = "Used to set an IAM Profile to EC2 instances"
  default = "TaggingRole"
}

variable "env_certs" {
  description = "Environment type"
  default = "true"
}

variable "comcast_service_name" {
  description = "Service name for AMI and Hostname naming convention (used internally; compliment to comcast_application_role)"
}

variable "role_id" {
  description = "RoleID for Vault authentication"
  type = "string"
  default = "RoleID"

}

variable "secret_id" {
  description = "SecretID for Vault authentication"
  type = "string"
  default = "SecretID"
}
