terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/prod-tsf-us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-tsf-autoscaling-west-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-0a961fc8b20384742"]
  aws_region                  = "us-west-2"
  user_data                   = "${file("userdata_west_prod")}"
   aws_subnets                = ["subnet-0b77a3bd071f4655d"]
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  data_center                 = "aw"
  name                        = "xvpsvc"
  iam_instance_profile        = "CustomerManagedBasic_TaggingRole"
  aws_profile                 = "tvx-ingrid-adproxy_acct_02112025"
  desired_capacity            = 18
  min_size                    = 18
  max_size                    = 20
  cpu_min                     = 50
  cpu_max                     = 70
  health_check_type           = "ELB"
  application_version         = var.application_version
  deployment_type             = "Auto Scaling Group"
  description                 = "SSL cert update, gp3, and IMDSv2 commands"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 3.
#Workspace naming format is blueocean_(version)_tsf_prod_east_(iteration number)
#Rail Subnets:
#Public - subnet-0746f789ec657e9eb
#Protected - subnet-059ac070e81b26122
#Min = 18
#Desired = 18
#Max = 18

#SG - sg-04285519007852828 is the SG for the Protected Rail for the xvp_capitalservices_adproxy_prod tenant. Later need to add sg-083c91f3a1cde02aa as well
