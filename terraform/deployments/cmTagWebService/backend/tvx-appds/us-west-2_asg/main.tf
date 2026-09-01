terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagWebService/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-cmTagWebService" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-affd71d5", "sg-e5cbb89f", "sg-0a5b6a10db8c48585","sg-0a29e00691af623eb","sg-0e0eb14503f6dc5fd"]
  aws_region                  = "us-west-2"
  aws_subnets                 = ["subnet-d5286a8c"]
  user_data                   = "${file("userdata_west_prod")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "appds.xcal.tv"
  data_center                 = "aw"
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
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard UI host count is 3.
#Workspace naming format is tagportal_(version)_aw_asg_(iteration number)