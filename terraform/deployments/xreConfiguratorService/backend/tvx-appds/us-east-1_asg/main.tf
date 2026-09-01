terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configds/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-configds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-0de8f248060bd89c0", "sg-0e61a5bacc3b3417c", "sg-39f23949", "sg-0e3d0bc6b8099638a", "sg-410e7034"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-da41b882"]
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
  name                        = "xvpsvc"
  desired_capacity            = 4
  min_size                    = 4
  max_size                    = 4
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 4.
#Workspace naming format is xreconfigds_(version)_ae_(iteration number)
