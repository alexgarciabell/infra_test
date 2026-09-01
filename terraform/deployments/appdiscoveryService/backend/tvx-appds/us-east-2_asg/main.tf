terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsds/us-east-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-ohio-adsds" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-03c42d3d882ef759f", "sg-6ed1db05", "sg-0772e42f00c7a43c0"]
  aws_region                  = "us-east-2"
  user_data                   = "${file("userdata_ohio")}"
  aws_subnets                 = ["subnet-918f79eb"]
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "appds.xcal.tv"
  data_center                 = "ao"
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
#Workspace naming format is adsds_(version)_ao_(iteration number)
#Need to test using c5.xlarge.