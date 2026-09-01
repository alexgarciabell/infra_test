terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/prod-tsf-us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-tsf-east-blueocean" {
  source                      = "../../../../../modules/dataServiceWProfile"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-04285519007852828"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east_prod")}"
  vpc_id                      = "vpc-0fb47f0a89b8bbbde"
  subnet_id                   = "subnet-059ac070e81b26122"
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "bluocn"
  domain                      = "iap.xcal.tv"
  key_pair                    = "iap-virginia"
  data_center                 = "ce"
  termination_protection      = "false"
  name                        = "tvxblo"
  iam_instance_profile        = "CustomerManagedBasic_TaggingRole"
  aws_profile                 = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard DS host count is 3.
#Workspace naming format is blueocean_(version)_tsf_prod_east_(iteration number)
#Rail Subnets:
#Public - subnet-0746f789ec657e9eb
#Protected - subnet-059ac070e81b26122

#SG - sg-04285519007852828 is the SG for the Protected Rail for the xvp_capitalservices_adproxy_prod tenant. Later need to add sg-083c91f3a1cde02aa as well