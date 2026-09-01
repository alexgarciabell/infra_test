variable "aws_access_key" {
  type    = string
  default = "${env("bamboo_AWS_ACCESS_KEY_ID")}"
}

variable "aws_secret_key" {
  type    = string
  default = "${env("bamboo_AWS_SECRET_ACCESS_KEY")}"
}

variable "ec2_region" {
  type    = string
  default = "${env("EC2_REGION")}"
}

variable "subnet_id" {
  type    = string
  default = "${env("SUBNET_ID")}"
}

variable "vpc_id" {
  type    = string
  default = "${env("VPC_ID")}"
}

data "amazon-ami" "filter_for_source_ami" {
  access_key  = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  owners      = ["713513710664"]
  region      = "${var.ec2_region}"
  most_recent = true

  filters = {
    architecture        = "x86_64"
    name                = "Comcast Amazon Linux 2023 -*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.
locals {
  now          = timestamp()
  ami_name     = "icfar-boilerplate-${formatdate("DD-MMM-YYYY-hh-mm-ss", "${local.now}")}"
  date_created = "${formatdate("DD-MMM-YYYY", "${local.now}")}"
}

source "amazon-ebs" "boilerplate" {
  access_key      = "${var.aws_access_key}"
  secret_key      = "${var.aws_secret_key}"
  region          = "${var.ec2_region}"
  vpc_id          = "${var.vpc_id}"
  subnet_id       = "${var.subnet_id}"
  source_ami      = "${data.amazon-ami.filter_for_source_ami.id}"
  ami_description = "${local.ami_name}"
  ami_name        = "${local.ami_name}"
  ami_regions     = ["us-east-1", "us-east-2", "us-west-2"]
  instance_type   = "c5.large"
  ssh_username    = "ec2-user"

  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    encrypted             = "false"
    volume_size           = "8"
    volume_type           = "gp3"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  run_tags = {
    Name = "${local.ami_name}"
  }

  run_volume_tags = {
    Name = "${local.ami_name}"
  }

  snapshot_tags = {
    Name                = "${local.ami_name}"
    built_from_ami_name = "{{ .SourceAMIName }}"
    crowdstrike         = "true"
    date-created        = "${legacy_isotime("02-Jan-2006")}"
    elasticsearch       = "false"
    notes               = "Boilerplate for XVP CS Services - Amazon Linux 2023 - Snapshot"
    opens               = "true"
    packer-generated    = "true"
    splunk              = "false"
    stable              = "true"
    vector              = "false"
  }

  tags = {
    Name                = "${local.ami_name}"
    built_from_ami_name = "{{ .SourceAMIName }}"
    crowdstrike         = "true"
    date-created        = "${local.date_created}"
    elasticsearch       = "false"
    notes               = "Boilerplate for XVP CS Services - Amazon Linux 2023"
    opens               = "true"
    packer-generated    = "true"
    splunk              = "false"
    stable              = "true"
    vector              = "false"
  }
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.amazon-ebs.boilerplate"]

  provisioner "shell" {
    inline = [
      "sudo systemctl stop EracentEDAService.service", "sudo systemctl stop EracentEPAService.service",
      "sudo yum install -y python-pip", "sudo pip3 install ansible", "sudo pip install --ignore-installed hvac==0.4.0",
      "sudo pip3 install lxml"
    ]
    remote_folder = "/home/ec2-user"
  }

  provisioner "ansible-local" {
    playbook_dir  = "../../ansible/plays/"
    playbook_file = "../../ansible/plays/boilerplateAL2023.yml"
    role_paths = [
      "../../ansible/roles/boilerplateAL2023", "../../ansible/roles/atlas-yumrepoAL2023", "../../ansible/roles/vector",
      "../../ansible/roles/crowdstrike", "../../ansible/roles/opens", "../../ansible/roles/eracent-cleaner",
      "../../ansible/roles/autobahn-config"
    ]
  }

  post-processor "manifest" {
    output     = "boilerplate_al2023_result_${legacy_isotime("02-Jan-2006")}.json"
    strip_path = true
  }
}