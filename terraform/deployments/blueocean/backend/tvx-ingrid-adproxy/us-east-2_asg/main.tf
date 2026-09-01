terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-2-asg/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-autoscaling-ohio-blueocean" {
  source                      = "../../../../../modules/autoscaling/with_no_nlb_profile"
  aws_instance_type           = "c5.xlarge"
#blueocean-backend-ohio          - sg-0718110706417b9bb
#blueocean-haproxy-ohio          - sg-08adcc4dc153f3569
  aws_security_groups         = ["sg-019fa2459bfabcb15", "sg-0718110706417b9bb", "sg-0b009c3bcd4c2201b", "sg-08adcc4dc153f3569"]
  aws_region                  = "us-east-2"
  aws_subnets                 = ["subnet-0776ec04ba261a419"]
  user_data                   = "${file("userdata_ohio_prod")}"
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  data_center                 = "ao"
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
#Workspace naming format is blueocean_(version)_ao_asg_(iteration number)