terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configds/us-east-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-ohio-configds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-6ed1db05", "sg-0498ce8b0f5cbcabc", "sg-08a1008de1fe0887f", "sg-06347f7e1a0967ace"]
  aws_region                  = "us-east-2"
  user_data                   = "${file("userdata_ohio")}"
  aws_subnets                 = ["subnet-918f79eb"]
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  domain                      = "appds.xcal.tv"
  data_center                 = "ao"
  name                        = "xvpsvc"
  desired_capacity            = 4
  min_size                    = 4
  max_size                    = 8
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 4.
#Workspace naming format is xreconfigds_(version)_ao_(iteration number)