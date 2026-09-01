terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-east-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-0aa07f1179941f19a"]
  aws_region                  = "us-east-1"
  user_data                   = "${file("userdata_east_ci")}"
  aws_subnets                 = ["subnet-042a30bfe2f0239d1"]
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  data_center                 = "de"
  name                        = "xvpsvc"
  iam_instance_profile        = "CustomerManagedBasic_TaggingRole"
  aws_profile                 = "tvx-ingrid-adproxy_acct_02112025"
  min_size                    = 1
  max_size                    = 1
  desired_capacity            = 1
  cpu_min                     = 5
  cpu_max                     = 40
  health_check_type           = "ELB"
  #application_port            = "443"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "Based on latest CSI (Comcast Amazon Linux 2 - 20250115)"
  version_id                  = var.version_id
}

#Workspace naming format is blueocean_(version)_do_asg_(iteration number)
# SGs : 
# sg-0d6651bc25f6931ac -  Internal-xvp_capitalservices_adproxy_ci-Public-xvp_cs_adproxy_east_va_ci_1
# sg-0aa07f1179941f19a - Internal-xvp_capitalservices_adproxy_ci-Protected-xvp_cs_adproxy_east_va_ci_1
# sg-00572690bd67bb050 - 	blueocean-backend-tsf-ci-manual
