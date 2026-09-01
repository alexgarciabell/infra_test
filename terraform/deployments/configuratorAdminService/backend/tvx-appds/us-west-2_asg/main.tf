terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configadmin/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-configadmin" {
  source                   = "../../../../../modules/autoscaling/with_no_nlb"
  aws_region               = "us-west-2"
  aws_instance_type        = "c5.xlarge"
  aws_security_groups      = ["sg-e5cbb89f", "sg-695f640d", "sg-7fe1a205", "sg-010cc992f46ab6f33", "sg-affd71d5", "sg-b852f7c4", "sg-005474c0048d8b6e4"]
  data_center              = "aw"
  domain                   = "appds.xcal.tv"
  user_data                = "${file("userdata_west")}"
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
  aws_subnets              = ["subnet-d5286a8c"]
  description              = "description about release"
  application_version      = var.application_version
  version_id               = var.version_id
}

#For PROD, standard UI host count is 1.
#Workspace naming format is xreconfigadmin_(version)_aw_asg_(iteration number)