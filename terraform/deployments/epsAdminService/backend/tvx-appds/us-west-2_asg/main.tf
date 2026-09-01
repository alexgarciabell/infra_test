terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsadmin/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-epsadmin" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-50ab4a37", "sg-02939504d7112a332", "sg-06abee1cc5ba4c799", "sg-74212605"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-d5286a8c"]
  comcast_application_name    = "epsadmin"
  comcast_application_role    = "epsui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsui"
  domain                      = "appds.xcal.tv"
  data_center                 = "aw"
  name                        = "xvpsvc"
  desired_capacity            = 1
  min_size                    = 1
  max_size                    = 2
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard UI host count is 1.
#Workspace naming format is epsadmin_(version)_aw_asg_(iteration number)