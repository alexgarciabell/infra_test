terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cseval/us-east-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-ohio-cseval" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-0c44547d8d446517a", "sg-6ed1db05", "sg-d6a544bc", "sg-0accf5e37be8d2113", "sg-01082ccfa43c59529"]
  aws_region                  = "us-east-2"
  user_data                   = "${file("userdata_ohio")}"
  aws_subnets                 = ["subnet-918f79eb"]
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "appds.xcal.tv"
  data_center                 = "ao"
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

#For PROD, standard DS host count is 3.
#Workspace naming format is cse_(version)_ae_(iteration number)