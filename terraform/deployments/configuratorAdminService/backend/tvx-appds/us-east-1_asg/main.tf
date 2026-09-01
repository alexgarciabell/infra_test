terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configadmin/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-configadmin" {
  source                   = "../../../../../modules/autoscaling/with_no_nlb"
  aws_region               = "us-east-1"
  aws_instance_type        = "c5.xlarge"
  aws_security_groups      = ["sg-39f23949", "sg-996f84e0", "sg-990fa2e9", "sg-07cfea3923832197e", "sg-74212605", "sg-72760807", "sg-08a21a9fc9e3448b2"]
  data_center              = "ae"
  domain                   = "appds.xcal.tv"
  user_data                = "${file("userdata_east")}"
  min_size                 = 1
  max_size                 = 5
  desired_capacity         = 1
  cpu_min                  = 50
  cpu_max                  = 70
  comcast_application_name = "xreconfiguratoradmin"
  comcast_application_role = "xcfgui"
  comcast_application_env  = "prod"
  comcast_iop_appid        = "31865"
  comcast_service_name     = "xcfgui"
  name                     = "xvpsvc"
  health_check_type        = "ELB"
  deployment_type          = "Auto Scaling Group"
  aws_subnets              = ["subnet-da41b882"]
  description              = "description about release"
  application_version      = var.application_version
  version_id               = var.version_id
}

#For PROD, standard UI host count is 1.
#Workspace naming format is xreconfigadmin_(version)_ae_asg_(iteration number)