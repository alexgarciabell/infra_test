terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/configds/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-east-configds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-88b78bed", "sg-a8e1eccd", "sg-49fcba2c", "sg-13387267", "sg-74b49806"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-e42182bd"]
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  domain                      = "do.xcal.tv"
  data_center                 = "de"
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
#Workspace naming format is xreconfigds_(version)_de_(iteration number)