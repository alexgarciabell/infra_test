terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/adsadmin/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-east-adsadmin" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-74b49806", "sg-a8e1eccd", "sg-13387267", "sg-88b78bed", "sg-f1be0b8d"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-e42182bd"]
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "ci"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "do.xcal.tv"
  data_center                 = "de"
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
}


#For CI, standard UI host count is 1.
#Workspace naming format is adsadmin_(version)_de_asg_(iteration number)
