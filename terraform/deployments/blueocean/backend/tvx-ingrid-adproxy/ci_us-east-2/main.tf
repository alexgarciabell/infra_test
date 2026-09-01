terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-2_2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-ohio-blueocean" {
  source                      = "../../../../../modules/dataServiceWProfile"
  instance_type               = "c5.xlarge"
# blueocean-backend-ci  sg-001be3fb67b6ea826 should be added later, instead of sg-002ca9c5dfce4e08b (tvx-do-ci)
  security_groups             = ["sg-019fa2459bfabcb15", "sg-0d4876ecd3a8d85d3", "sg-002ca9c5dfce4e08b", "sg-0b009c3bcd4c2201b", "sg-0718110706417b9bb"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_ohio_ci")}"
  vpc_id                      = "vpc-0dc2bb57a8fde711a"
  subnet_id                   = "subnet-0776ec04ba261a419"
  comcast_application_name    = "blueocean"
  comcast_application_role    = "blueocean"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "67699"
  comcast_service_name        = "blueocean"
  domain                      = "iap.xcal.tv"
  key_pair                    = "iap-ohio"
  data_center                 = "oh"
  termination_protection      = "false"
  name                        = "tvxblo"
  iam_instance_profile        = "CustomerManagedBasic_TaggingRole"
  aws_profile                 = "tvx-ingrid-adproxy_acct_02112025"
}

#For CI, standard DS host count is 3.
#Workspace naming format is blueocean_(version)_do_(iteration number)