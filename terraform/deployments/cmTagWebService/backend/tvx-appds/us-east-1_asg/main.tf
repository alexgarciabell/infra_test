terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagWebService/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-cmTagWebService" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-39f23949", "sg-0ba31f5444e283d9b", "sg-01bcecb41607a46c4", "sg-060200d55e68865ee", "sg-74212605"]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-da41b882"]
  user_data                   = "${file("userdata_east_prod")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
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
#Workspace naming format is tagportal_(version)_ae_asg_(iteration number)