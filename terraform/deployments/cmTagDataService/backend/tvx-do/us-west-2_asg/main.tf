terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagDataService/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-west-cmtagds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-0cb6b93c4d05f5c16", "sg-28e5374f", "sg-6776cd02", "sg-d8da89a5", "sg-f57d2d91"]
  aws_region                  = "us-west-2"
  aws_subnets                 = ["subnet-66fb3103"]
  user_data                   = "${file("userdata_west")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "do.xcal.tv"
  data_center                 = "dw"
  name                        = "xvpsvc"
  desired_capacity            = 3
  min_size                    = 3
  max_size                    = 5
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is tagds_(version)_dw_(iteration number)
#Currently, we do not normally deploy to DO West