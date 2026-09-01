terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-1-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-east-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
#blueocean-backend-east          - sg-0eec9d104aa903d3a
#blueocean-haproxy-east          - sg-0bdbd5975608fb2a0
  aws_security_groups         = ["sg-0689c92048bc8ddf3", "sg-0036586f83e920cf7", "sg-0eec9d104aa903d3a", "sg-0bdbd5975608fb2a0"]
  aws_region                  = "us-east-1"
  aws_subnets                 = ["subnet-025e9088237ac3a15"]
  user_data                   = "${file("userdata_east_prod")}"
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  data_center                 = "ae"
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
#Workspace naming format is blueocean_(version)_ae_asg_(iteration number)