terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-west-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-west-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
#blueocean-backend-west          - sg-06cce4398cb0d7d8e
#blueocean-haproxy-west          - sg-057640624336578b8
  aws_security_groups         = ["sg-0cfb6afaf3b8e9d42", "sg-06cce4398cb0d7d8e", "sg-02464c313cf03993f", "sg-057640624336578b8"]
  aws_region                  = "us-west-2"
  aws_subnets                 = ["subnet-0527663451bb87223"]
  user_data                   = "${file("userdata_west_prod")}"
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
  description                 = "description about release"
  version_id                  = var.version_id
}

#For PROD, standard DS host count is 18.
#Workspace naming format is blueocean_(version)_aw_asg_(iteration number)