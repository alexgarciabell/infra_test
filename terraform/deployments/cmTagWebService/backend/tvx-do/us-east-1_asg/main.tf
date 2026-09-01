terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagWebService/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-east-cmTagWebService" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-74b49806", "sg-01ce77aea6663f4b9", "sg-13387267","sg-00c93ee44224bd5c8"]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-e42182bd"]
  user_data                   = "${file("userdata_east_ci")}"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
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
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For CI, standard UI host count is 2.
#Workspace naming format is tagportal_(version)_de_asg_(iteration number)