terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagWebService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-cmTagWebService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-0a29e00691af623eb","sg-e5cbb89f","sg-0e0eb14503f6dc5fd", "sg-073255d46d2a52664", "sg-0a5b6a10db8c48585"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  subnet_id                   = "subnet-d5286a8c"
  user_data                   = "${file("userdata_west_prod")}"
  vpc_id                      = "vpc-74695511"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
 }

#For PROD, standard UI host count is 1.
#Workspace naming format is tagportal_(version)_aw_(iteration number)