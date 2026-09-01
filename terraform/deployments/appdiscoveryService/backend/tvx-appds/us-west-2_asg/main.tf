terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsds/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-adsds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-080292d199df623ab", "sg-e5cbb89f", "sg-0ca7f62adea8b092f"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-d5286a8c"]
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "appds.xcal.tv"
  data_center                 = "aw"
  name                        = "xvpsvc"
  desired_capacity            = 40
  min_size                    = 40
  max_size                    = 50
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 40.
#Workspace naming format is adsds_(version)_aw_(iteration number)
#Need to test using c5.xlarge.