terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsds/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-epsds" {

  source                      = "../../../../../modules/autoscaling/with_no_nlb"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-39f23949", "sg-20b71454", "sg-27b11253", "sg-0a55f11c4485d3535","sg-0d3cf14cb959f5706" ]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-da41b882"]
  user_data                   = "${file("userdata_east")}"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  domain                      = "appds.xcal.tv"
  data_center                 = "ae"
  name                        = "xvpsvc"
  desired_capacity            = 20
  min_size                    = 20
  max_size                    = 24
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "Update to 2.56.15. Vector config Git repo update."
  version_id                  = var.version_id
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard DS host count is 12.
#Workspace naming format is epsds_(version)_asg_ae_(iteration number)
