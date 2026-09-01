terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-2_2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-autoscaling-ohio-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
  aws_security_groups         = ["sg-019fa2459bfabcb15", "sg-0b009c3bcd4c2201b", "sg-0c16277223c7fa941", "sg-002ca9c5dfce4e08b", "sg-0c0f09127ecf581a7", "sg-0d4876ecd3a8d85d3"]
  aws_region                  = "us-east-2"
  user_data                   = "${file("userdata_ohio_ci")}"
  aws_subnets                 = ["subnet-0a016881ca5d005b5"]
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  data_center                 = "po"
  name                        = "xvpsvc"
  iam_instance_profile        = "CustomerManagedBasic_TaggingRole"
  aws_profile                 = "tvx-ingrid-adproxy_acct_02112025"
  min_size                    = 1
  max_size                    = 3
  desired_capacity            = 2
  cpu_min                     = 5
  cpu_max                     = 40
  health_check_type           = "ELB"
  #application_port            = "443"
  #application_version         = var.application_version
  application_version         = "1.7.14"
  deployment_type             = "Auto Scaling Group"
  description                 = "Based on latest CSI (Comcast Amazon Linux 2 - 20250115)"
  #version_id                  = var.version_id
  version_id                  = "3"
}

#Workspace naming format is blueocean_(version)_do_asg_(iteration number)