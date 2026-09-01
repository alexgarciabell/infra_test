# Specify the provider and access details

 terraform {
   required_version = ">= 0.13"

  required_providers {
    aws = {
       source  = "hashicorp/aws"
      version = "~> 3.0"
     }
   }
 }

provider "aws" {
  region  = "${var.aws_region}"
}


resource "random_string" "stacknamestring" {
  length  = 2
  special = false
  upper   = false
}

#resource "random_integer" "rand_host_num" {
#  min = 100
#  max = 999
#
#  keepers = {
#    new_num_val = var.name
#  }
#}

data "template_file" "user_data" {
  template = "${var.user_data}"

  vars = {
    data_center              = "${var.data_center}"
    random_string            = "${random_string.stacknamestring.result}"
    comcast_application_name = "${var.comcast_application_name}"
    comcast_application_role = "${var.comcast_application_role}"
    domain_name              = "${var.domain}"
    role_id                  = var.role_id
    secret_id                = var.secret_id
  }
}

###############################################################################################
# EC2 Instance pulling latest image
###############################################################################################
data "aws_ami" "application_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["icfar-${var.comcast_service_name}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "tag:stable"
    values = ["true"]
  }

  owners = ["self"]
}

###############################################################################################
# EC2 Instance 
###############################################################################################

resource "aws_instance" "icfar-ec2-tspadmin" {
  ami                          = data.aws_ami.application_ami.id
  instance_type                = var.aws_instance_type
  subnet_id                    = var.aws_subnets[0]
  user_data                     = base64encode(data.template_file.user_data.rendered)
  iam_instance_profile          = var.iam_instance_profile

  associate_public_ip_address = false  
  security_groups             = var.aws_security_groups 

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name                          = "${var.name}-${var.data_center}-${random_string.stacknamestring.result}-${var.comcast_service_name}-host.${var.domain}"
    ComcastApplicationEnvironment = var.comcast_application_env
    ComcastApplicationName        = var.comcast_application_name
    ComcastApplicationRole        = var.comcast_application_role
    ComcastIOPApplicationID       = var.comcast_iop_appid
    TerraformWorkSpace            = terraform.workspace
    #IsTargetGroupAttached         = "false"
    ApplicationVersion            = var.application_version
    Version                       = var.version_id
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ami]
  }
}