terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsadmin/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-epsadmin" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-021d7a7b", "sg-0423a87fd69416428", "sg-06abee1cc5ba4c799", "sg-74212605"]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-da41b882"]
  user_data                   = "${file("userdata_east")}"
  comcast_application_name    = "epsadmin"
  comcast_application_role    = "epsui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsui"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
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
#Workspace naming format is epsadmin_(version)_ae_asg_(iteration number)