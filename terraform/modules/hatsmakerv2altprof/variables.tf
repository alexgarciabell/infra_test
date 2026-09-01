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
variable "vpc_id" {
  description = "VPC ID to launch instance"
}

variable "instance_type" {
  description = "Instance Type"
  default     = "c5.xlarge"
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

variable "name" {
  description = "Hostname of instance"
  default     = "tvxhat"
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
  default = "LoadBalancer"
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

#gdejes200
#These are additional variables meant to expand on the Hatsmaker/HAProxy Terraform configs.
#At some point, these should be merged into the hatsmaker module and all workspaces updated accordingly.

variable "short_name" {
  description = "Friendly name to identify the service that is being used by this host."
}

variable "service_name" {
  description = "Service name"
}

variable "cert_name" {
  description = "Name to use to be able to extract the correct SSL Cert"
}

variable "haproxy_template" {
  description = "Haproxy template"
}

variable "service_ssl_port" {
  description = "SSL port for the service"
}

variable "service_ssl_ipv6_enabled" {
  description = "Used to enable IPv6 binding for the service"
}

variable "ipv6_address_count" {
  description = "Assign IPv6 address from AWS if the count is 1"
  default = 0
}

variable "service_ssl_backend_enabled" {
  description = "Used to enable backend SSL for the service"
}

variable "hats_id" {
  description = "Hats Id used for the sevice"
}

variable "env_type" {
  description = "Environment type"
}

variable "have_ipv6" {
  description = "Indicates whether the resources should have IPv6 enabled - Values: yes/no"
  default = "no"
}

variable "environment_label" {
  description = "States what environment the resources are located in. Requires have_ipv6=yes"
  default = ""
}

variable "mtls_mode" {
  description = "States whether mtls is not relevant, optional, or required"
  default = "none"
}

variable "ads_tsp_cb_url" {
  description = "(Legacy) States what the CodeBig URL is for ADS TSP"
  default = "none"
}

variable "ads_tsp_normal_url" {
  description = "States what the normal URL is for ADS TSP"
  default = "none"
}

variable "env_certs" {
  description = "Notes whether environment SSL certs are in use (servicename/env/certs/pem)"
  default     = "false"
}

variable "elk_domain" {
  description = "Elastic endpoint"
}

variable "vector_log_index" {
  description = "Elastic index for vector internal logs"
}

variable "haproxy_log_index" {
  description = "Elastic index for HAProxy logs"
}

variable "iam_instance_profile" {
  description = "Used to set an IAM Profile to EC2 instances"
  default = "TaggingRole"
}

#gdejes200
#Note: This follows the profile convention from the AWS CLI. In order to use this, the profiles need to be set up for the
# user that's running it. By default, the profile information will be in ~/.aws. There are 2 files that are needed there:
#- credentials - This is where the profile information exists
#- configs - This lists the available profiles and other configs related to the AWS CLI
#Ref: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

variable "aws_profile" {
  description = "Notes what AWS profile to use for the credentials"
  default = "NA"
}
