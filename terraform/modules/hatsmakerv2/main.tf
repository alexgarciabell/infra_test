# Specify the provider and access details
# The previous AWS provider version was 2.0.0.
# The AWS provider version that first supported metadata_options is 2.55.0.
# The last 2.x AWS provider version is 2.70.4.
# Make sure to download the provisioners from these locations of the proper architecture version:
# - https://releases.hashicorp.com/terraform-provider-aws/2.70.4/
# - https://releases.hashicorp.com/terraform-provider-aws/2.55.0/
# Put these in /home/xdeploy/.terraform.d/plugins/linux_amd64
provider "aws" {
  region  = "${var.aws_region}"
  version = "2.70.4"
}

data "aws_ami" "hatsmaker_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["icfar-hatsmakerv2-*"]
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

data "template_file" "user_data" {
  template = "${file("${var.user_data}")}"

  vars = {
      service_name                = "${var.service_name}"
      cert_name                   = "${var.cert_name}"
      env_certs                   = "${var.env_certs}"
      elk_domain                  = "${var.elk_domain}"
      vector_log_index            = "${var.vector_log_index}"
      haproxy_log_index           = "${var.haproxy_log_index}"
      haproxy_template            = "${var.haproxy_template}"
      service_ssl_port            = "${var.service_ssl_port}"
      service_ssl_ipv6_enabled    = "${var.service_ssl_ipv6_enabled}"
      service_ssl_backend_enabled = "${var.service_ssl_backend_enabled}"
      hats_id                     = "${var.hats_id}"
      env_type                    = "${var.env_type}"
      have_ipv6                   = "${var.have_ipv6}"
      environment_label           = "${var.environment_label}"
      mtls_mode                   = "${var.mtls_mode}"
      swidtag_file                = "${var.swidtag_file}"
      ads_tsp_cb_url              = "${var.ads_tsp_cb_url}"
      ads_tsp_normal_url          = "${var.ads_tsp_normal_url}"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = "${var.vpc_id}"
}

resource "random_string" "stacknamestring" {
  length  = 2
  special = false
  upper   = false
}

resource "aws_instance" "single_subnet_hatsmaker_instance" {
  count                  = "${var.single_subnet_instance_count}"
  ami                    = "${data.aws_ami.hatsmaker_ami.id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = "${var.security_groups}"

  # us-east-1 in tvx-appds account, subnet-a87de895 is blacklisted
  subnet_id               = "${var.subnet_id}"
  key_name                = "${var.key_pair}"
  iam_instance_profile    = "TaggingRole"
  disable_api_termination = "${var.termination_protection}"
  user_data               = "${data.template_file.user_data.rendered}"

  ipv6_address_count      = "${var.ipv6_address_count}"

  tags = {
    Name                          = "${var.name}-${var.data_center}-${random_string.stacknamestring.result}-${var.short_name}-${count.index}.${var.domain}"
    ComcastApplicationName        = "${var.comcast_application_name}"
    ComcastApplicationRole        = "${var.comcast_application_role}"
    ComcastApplicationEnvironment = "${var.comcast_application_env}"
    ComcastIOPApplicationID       = "${var.comcast_iop_appid}"
    DeploymentType                = "${var.deployment_type}"
    TerraformWorkSpace            = "${terraform.workspace}"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

resource "aws_instance" "multi_subnet_hatsmaker_instance" {
  count                  = "${var.multi_subnet_instance_count}"
  ami                    = "${data.aws_ami.hatsmaker_ami.id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = "${var.security_groups}"

  # us-east-1 in tvx-appds account, subnet-a87de895 is blacklisted, we only want to use subnet-da41b882 if the VPC is vpc-08b9236c
  subnet_id               = "${var.vpc_id == "vpc-08b9236c" ? "subnet-da41b882" : element(data.aws_subnet_ids.all.ids,count.index)}"
  key_name                = "${var.key_pair}"
  iam_instance_profile    = "TaggingRole"
  disable_api_termination = "${var.termination_protection}"
  user_data               = "${data.template_file.user_data.rendered}"

  tags = {
    Name                          = "${var.name}-${var.data_center}-${random_string.stacknamestring.result}-${var.short_name}-${count.index}.${var.domain}"
    ComcastApplicationName        = "${var.comcast_application_name}"
    ComcastApplicationRole        = "${var.comcast_application_role}"
    ComcastApplicationEnvironment = "${var.comcast_application_env}"
    ComcastIOPApplicationID       = "${var.comcast_iop_appid}"
    DeploymentType                = "${var.deployment_type}"
    TerraformWorkSpace            = "${terraform.workspace}"
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}