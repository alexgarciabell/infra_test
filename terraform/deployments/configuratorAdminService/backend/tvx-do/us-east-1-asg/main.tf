terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/configadmin/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-east-configadmin" {
  source                   = "../../../../../modules/autoscaling/with_no_nlb"
  aws_region               = "us-east-1"
  aws_instance_type        = "c5.xlarge"
  aws_security_groups      = ["sg-88b78bed", "sg-a8e1eccd", "sg-74b49806", "sg-13387267"]
  data_center              = "de"
  domain                   = "do.xcal.tv"
  user_data                = "${file("userdata_east")}"
  min_size                 = 2
  max_size                 = 5
  desired_capacity         = 2
  cpu_min                  = 50
  cpu_max                  = 70
  comcast_application_name = "xreconfiguratoradmin"
  comcast_application_role = "xcfgui"
  comcast_application_env  = "ci"
  comcast_iop_appid        = "31865"
  comcast_service_name     = "xcfgui"
  name                     = "xvpsvc"
  health_check_type        = "ELB"
  deployment_type          = "Auto Scaling Group"
  aws_subnets              = ["subnet-e42182bd"]
  description              = "description about release"
  application_version      = var.application_version
  version_id               = var.version_id
}

#For CI, standard UI host count is 2.
#Workspace naming format is xreconfigadmin_(version)_de_asg_(iteration number)