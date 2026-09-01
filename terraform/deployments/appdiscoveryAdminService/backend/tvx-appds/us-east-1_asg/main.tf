terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsadmin/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-adsadmin" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-39f23949", "sg-996f84e0", "sg-b50adbcf", "sg-096aa2960f02ad591","sg-74212605"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east")}"
  aws_subnets                 = ["subnet-da41b882"]
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "prod"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
  name                        = "xvpsvc"
  desired_capacity            = 2
  min_size                    = 2
  max_size                    = 5
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard UI host count is 1.
#Workspace naming format is adsadmin_(version)_ae_asg_(iteration number)