terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/ci-tsf-us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-tsf-east-blueocean" {
  source                      = "../../../../../modules/dataServiceWProfile"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-0aa07f1179941f19a"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east_ci")}"
  vpc_id                      = "vpc-03893e6980a4a4010"
  subnet_id                   = "subnet-042a30bfe2f0239d1"
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "ci"
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

#For CI, standard DS host count is 3.
#Workspace naming format is blueocean_(version)_tsf_ci_east_(iteration number)
#Rail Subnets:
#Public - subnet-013ba2c5a0501d26b
#Protected - subnet-042a30bfe2f0239d1