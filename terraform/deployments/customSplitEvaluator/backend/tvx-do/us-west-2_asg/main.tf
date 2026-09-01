terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cseval/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-west-cseval" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-06a8a219be82d7cce", "sg-d8da89a5", "sg-b0000dcc", "sg-0f9e59b5fee33bda5"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-66fb3103"]
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "do.xcal.tv"
  data_center                 = "dw"
  name                        = "xvpsvc"
  desired_capacity            = 2
  min_size                    = 2
  max_size                    = 3
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is cse_(version)_de_(iteration number)