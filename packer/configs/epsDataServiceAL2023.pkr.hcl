variable "artifact_version" {
  type    = string
  default = "${env("ARTIFACT_VERSION")}"
}

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

variable "ROLE_ID" {
  type    = string
  default = "${env("ROLE_ID")}"
}

variable "SECRET_ID" {
  type    = string
  default = "${env("SECRET_ID")}"
}

data "amazon-ami" "filter_for_source_ami" {
  access_key = "${var.aws_access_key}"
  secret_key  = "${var.aws_secret_key}"
  region      = "${var.ec2_region}"
  owners      = ["self"]
  most_recent = true

  filters = {
    name                = "icfar-boilerplate-*"
    root-device-type    = "ebs"
    "tag:stable"        = "true"
    virtualization-type = "hvm"
  }
}

# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.
locals {
  now          = timestamp()
  ami_name     = "icfar-epsds-${formatdate("DD-MMM-YYYY-hh-mm-ss", "${local.now}")}"
  date_created = "${formatdate("DD-MMM-YYYY", "${local.now}")}"
}

source "amazon-ebs" "epsDataService" {
  access_key      = "${var.aws_access_key}"
  secret_key      = "${var.aws_secret_key}"
  region          = "${var.ec2_region}"
  vpc_id          = "${var.vpc_id}"
  subnet_id       = "${var.subnet_id}"
  source_ami      = "${data.amazon-ami.filter_for_source_ami.id}"
  ami_description = "${local.ami_name}"
  ami_name        = "${local.ami_name}"
  ssh_username    = "ec2-user"
  instance_type   = "m5.large"
  ami_regions     = ["us-east-1", "us-west-2"]

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
    artifact_version    = "${var.artifact_version}"
    built_from_ami_name = "{{ .SourceAMIName }}"
    crowdstrike         = "true"
    date-created        = "${local.date_created}"
    elasticsearch       = "true"
    notes               = "Service AMI For EPS DS - Snapshot (AL2023)"
    opens               = "true"
    packer-generated    = "true"
    splunk              = "false"
    stable              = "true"
    vector              = "true"
  }

  tags = {
    Name                = "${local.ami_name}"
    artifact_version    = "${var.artifact_version}"
    built_from_ami_name = "{{ .SourceAMIName }}"
    crowdstrike         = "true"
    date-created        = "${local.date_created}"
    elasticsearch       = "true"
    notes               = "Service AMI For EPS DS (AL2023)"
    opens               = "true"
    packer-generated    = "true"
    splunk              = "false"
    stable              = "true"
    vector              = "true"
  }
}

build {
  sources = ["source.amazon-ebs.epsDataService"]

  provisioner "ansible-local" {
    extra_arguments = [
      "-vvv",
      "--extra-vars \"artifact_version=${var.artifact_version} role_id=${var.ROLE_ID} secret_id=${var.SECRET_ID}\""
    ]
    playbook_dir  = "../../ansible/plays/"
    playbook_file = "../../ansible/plays/epsDataService.yml"
    role_paths = [
      "../../ansible/roles/java", "../../ansible/roles/jetty", "../../ansible/roles/epsDataService",
      "../../ansible/roles/eracent-installer"
    ]
  }

  provisioner "shell" {
    inline = ["sudo cp -r /tmp/packer-provisioner-ansible-local /home/ec2-user"]
    remote_folder = "/home/ec2-user"
  }

  post-processor "manifest" {
    output     = "epsds_al2023_result_${legacy_isotime("02-Jan-2006")}.json"
    strip_path = true
  }
}
