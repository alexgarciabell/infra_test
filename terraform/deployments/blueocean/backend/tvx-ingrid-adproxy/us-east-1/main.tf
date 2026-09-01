terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-blueocean" {
  source                       = "../../../../../modules/dataServiceWProfile"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-0689c92048bc8ddf3", "sg-0036586f83e920cf7", "sg-0c637adc9de68277a", "sg-0eec9d104aa903d3a"]
  aws_region                   = "us-east-1"
  single_subnet_instance_count = 18
  user_data                    = "${file("userdata_east_prod")}"
  vpc_id                       = "vpc-0a3f2e0d219051aa2"
  subnet_id                    = "subnet-0af330d8a445cfeba"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "blueocean"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "67699"
  domain                       = "iap.xcal.tv"
  key_pair                     = "iap-virginia"
  data_center                  = "ae"
  termination_protection       = "false"
  name                         = "tvxblo"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard DS host count is 18.
#Workspace naming format is blueocean_(version)_ae_(iteration number)