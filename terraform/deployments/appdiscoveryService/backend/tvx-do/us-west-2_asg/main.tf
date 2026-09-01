terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/adsds/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-west-adsds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-28e5374f", "sg-6776cd02", "sg-f57d2d91", "sg-d8da89a5"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west")}"
  aws_subnets                 = ["subnet-66fb3103"]
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "do.xcal.tv"
  data_center                 = "dw"
  name                        = "xvpsvc"
  desired_capacity            = 2
  min_size                    = 2
  max_size                    = 3
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "description about release"
  version_id                  = var.version_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is adsds_(version)_dw_(iteration number)
#Need to re-test using c5.xlarge.